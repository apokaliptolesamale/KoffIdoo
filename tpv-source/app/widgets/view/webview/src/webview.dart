// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../webview_android_cookie_manager.dart';
import '../webview_flutter_platform_interface.dart';
import '../webview_surface_android.dart';
import 'webview_cupertino.dart';
import 'wkwebview_cookie_manager.dart';

// This method assumes that no fields in `currentValue` are null.
WebSettings _clearUnchangedWebSettings(
    WebSettings currentValue, WebSettings newValue) {
  assert(currentValue.javascriptMode != null);
  assert(currentValue.hasNavigationDelegate != null);
  assert(currentValue.hasProgressTracking != null);
  assert(currentValue.debuggingEnabled != null);
  assert(newValue.javascriptMode != null);
  assert(newValue.hasNavigationDelegate != null);
  assert(newValue.debuggingEnabled != null);
  assert(newValue.zoomEnabled != null);

  JavascriptMode? javascriptMode;
  bool? hasNavigationDelegate;
  bool? hasProgressTracking;
  bool? debuggingEnabled;
  WebSetting<String?> userAgent = const WebSetting<String?>.absent();
  bool? zoomEnabled;
  if (currentValue.javascriptMode != newValue.javascriptMode) {
    javascriptMode = newValue.javascriptMode;
  }
  if (currentValue.hasNavigationDelegate != newValue.hasNavigationDelegate) {
    hasNavigationDelegate = newValue.hasNavigationDelegate;
  }
  if (currentValue.hasProgressTracking != newValue.hasProgressTracking) {
    hasProgressTracking = newValue.hasProgressTracking;
  }
  if (currentValue.debuggingEnabled != newValue.debuggingEnabled) {
    debuggingEnabled = newValue.debuggingEnabled;
  }
  if (currentValue.userAgent != newValue.userAgent) {
    userAgent = newValue.userAgent;
  }
  if (currentValue.zoomEnabled != newValue.zoomEnabled) {
    zoomEnabled = newValue.zoomEnabled;
  }

  return WebSettings(
    javascriptMode: javascriptMode,
    hasNavigationDelegate: hasNavigationDelegate,
    hasProgressTracking: hasProgressTracking,
    debuggingEnabled: debuggingEnabled,
    userAgent: userAgent,
    zoomEnabled: zoomEnabled,
  );
}

CreationParams _creationParamsfromWidget(WebView widget) {
  return CreationParams(
    initialUrl: widget.initialUrl,
    webSettings: _webSettingsFromWidget(widget),
    javascriptChannelNames: _extractChannelNames(widget.javascriptChannels),
    userAgent: widget.userAgent,
    autoMediaPlaybackPolicy: widget.initialMediaPlaybackPolicy,
    backgroundColor: widget.backgroundColor,
    cookies: widget.initialCookies,
  );
}

Set<String> _extractChannelNames(Set<JavascriptChannel>? channels) {
  final Set<String> channelNames = channels == null
      ? <String>{}
      : channels.map((JavascriptChannel channel) => channel.name).toSet();
  return channelNames;
}

// Throws an ArgumentError if `url` is not a valid URL string.
void _validateUrlString(String url) {
  try {
    final Uri uri = Uri.parse(url);
    if (uri.scheme.isEmpty) {
      throw ArgumentError('Missing scheme in URL string: "$url"');
    }
  } on FormatException catch (e) {
    throw ArgumentError(e);
  }
}

WebSettings _webSettingsFromWidget(WebView widget) {
  return WebSettings(
    javascriptMode: widget.javascriptMode,
    hasNavigationDelegate: widget.navigationDelegate != null,
    hasProgressTracking: widget.onProgress != null,
    debuggingEnabled: widget.debuggingEnabled,
    gestureNavigationEnabled: widget.gestureNavigationEnabled,
    allowsInlineMediaPlayback: widget.allowsInlineMediaPlayback,
    userAgent: WebSetting<String?>.of(widget.userAgent),
    zoomEnabled: widget.zoomEnabled,
  );
}

/// Decides how to handle a specific navigation request.
///
/// The returned [NavigationDecision] determines how the navigation described by
/// `navigation` should be handled.
///
/// See also: [WebView.navigationDelegate].
typedef NavigationDelegate = FutureOr<NavigationDecision> Function(
    NavigationRequest navigation);

/// Signature for when a [WebView] has finished loading a page.
typedef PageFinishedCallback = void Function(String url);

/// Signature for when a [WebView] is loading a page.
typedef PageLoadingCallback = void Function(int progress);

/// Signature for when a [WebView] has started loading a page.
typedef PageStartedCallback = void Function(String url);

/// Signature for when a [WebView] has failed to load a resource.
typedef WebResourceErrorCallback = void Function(WebResourceError error);

/// Optional callback invoked when a web view is first created. [controller] is
/// the [WebViewController] for the created web view.
typedef WebViewCreatedCallback = void Function(WebViewController controller);

/// Manages cookies pertaining to all [WebView]s.
class CookieManager {
  static CookieManager? _instance;

  /// Creates a [CookieManager] -- returns the instance if it's already been called.
  factory CookieManager() {
    return _instance ??= CookieManager._();
  }

  CookieManager._() {
    if (WebViewCookieManagerPlatform.instance == null) {
      if (Platform.isAndroid) {
        WebViewCookieManagerPlatform.instance = WebViewAndroidCookieManager();
      } else if (Platform.isIOS) {
        WebViewCookieManagerPlatform.instance = WKWebViewCookieManager();
      } else {
        throw AssertionError(
            'This platform is currently unsupported by webview_flutter.');
      }
    }
  }

  /// Clears all cookies for all [WebView] instances.
  ///
  /// Returns true if cookies were present before clearing, else false.
  Future<bool> clearCookies() =>
      WebViewCookieManagerPlatform.instance!.clearCookies();

  /// Sets a cookie for all [WebView] instances.
  ///
  /// This is a no op on iOS versions below 11.
  Future<void> setCookie(WebViewCookie cookie) =>
      WebViewCookieManagerPlatform.instance!.setCookie(cookie);
}

/// A decision on how to handle a navigation request.
enum NavigationDecision {
  /// Prevent the navigation from taking place.
  prevent,

  /// Allow the navigation to take place.
  navigate,
}

/// Information about a navigation action that is about to be executed.
class NavigationRequest {
  /// The URL that will be loaded if the navigation is executed.
  final String url;

  /// Whether the navigation request is to be loaded as the main frame.
  final bool isForMainFrame;

  NavigationRequest._({required this.url, required this.isForMainFrame});

  @override
  String toString() {
    return 'NavigationRequest(url: $url, isForMainFrame: $isForMainFrame)';
  }
}

/// A web view widget for showing html content.
///
/// There is a known issue that on iOS 13.4 and 13.5, other flutter widgets covering
/// the `WebView` is not able to block the `WebView` from receiving touch events.
/// See https://github.com/flutter/flutter/issues/53490.
class WebView extends StatefulWidget {
  static WebViewPlatform? _platform;

  /// The WebView platform that's used by this WebView.
  ///
  /// The default value is [SurfaceAndroidWebView] on Android and [CupertinoWebView] on iOS.
  static WebViewPlatform get platform {
    if (_platform == null) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          _platform = SurfaceAndroidWebView();
          break;
        case TargetPlatform.iOS:
          _platform = CupertinoWebView();
          break;
        default:
          throw UnsupportedError(
              "Trying to use the default webview implementation for $defaultTargetPlatform but there isn't a default one");
      }
    }
    return _platform!;
  }

  /// Sets a custom [WebViewPlatform].
  ///
  /// This property can be set to use a custom platform implementation for WebViews.
  ///
  /// Setting `platform` doesn't affect [WebView]s that were already created.
  ///
  /// The default value is [AndroidWebView] on Android and [CupertinoWebView] on iOS.
  static set platform(WebViewPlatform? platform) {
    _platform = platform;
  }

  /// If not null invoked once the web view is created.
  final WebViewCreatedCallback? onWebViewCreated;

  /// Which gestures should be consumed by the web view.
  ///
  /// It is possible for other gesture recognizers to be competing with the web view on pointer
  /// events, e.g if the web view is inside a [ListView] the [ListView] will want to handle
  /// vertical drags. The web view will claim gestures that are recognized by any of the
  /// recognizers on this list.
  ///
  /// When this set is empty or null, the web view will only handle pointer events for gestures that
  /// were not claimed by any other gesture recognizer.
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  /// The initial URL to load.
  final String? initialUrl;

  /// The initial cookies to set.
  final List<WebViewCookie> initialCookies;

  /// Whether JavaScript execution is enabled.
  final JavascriptMode javascriptMode;

  /// The set of [JavascriptChannel]s available to JavaScript code running in the web view.
  ///
  /// For each [JavascriptChannel] in the set, a channel object is made available for the
  /// JavaScript code in a window property named [JavascriptChannel.name].
  /// The JavaScript code can then call `postMessage` on that object to send a message that will be
  /// passed to [JavascriptChannel.onMessageReceived].
  ///
  /// For example for the following JavascriptChannel:
  ///
  /// ```dart
  /// JavascriptChannel(name: 'Print', onMessageReceived: (JavascriptMessage message) {   });
  /// ```
  ///
  /// JavaScript code can call:
  ///
  /// ```javascript
  /// Print.postMessage('Hello');
  /// ```
  ///
  /// To asynchronously invoke the message handler which will print the message to standard output.
  ///
  /// Adding a new JavaScript channel only takes affect after the next page is loaded.
  ///
  /// Set values must not be null. A [JavascriptChannel.name] cannot be the same for multiple
  /// channels in the list.
  ///
  /// A null value is equivalent to an empty set.
  final Set<JavascriptChannel>? javascriptChannels;

  /// A delegate function that decides how to handle navigation actions.
  ///
  /// When a navigation is initiated by the WebView (e.g when a user clicks a link)
  /// this delegate is called and has to decide how to proceed with the navigation.
  ///
  /// See [NavigationDecision] for possible decisions the delegate can take.
  ///
  /// When null all navigation actions are allowed.
  ///
  /// Caveats on Android:
  ///
  ///   * Navigation actions targeted to the main frame can be intercepted,
  ///     navigation actions targeted to subframes are allowed regardless of the value
  ///     returned by this delegate.
  ///   * Setting a navigationDelegate makes the WebView treat all navigations as if they were
  ///     triggered by a user gesture, this disables some of Chromium's security mechanisms.
  ///     A navigationDelegate should only be set when loading trusted content.
  ///   * On Android WebView versions earlier than 67(most devices running at least Android L+ should have
  ///     a later version):
  ///     * When a navigationDelegate is set pages with frames are not properly handled by the
  ///       webview, and frames will be opened in the main frame.
  ///     * When a navigationDelegate is set HTTP requests do not include the HTTP referer header.
  final NavigationDelegate? navigationDelegate;

  /// Controls whether inline playback of HTML5 videos is allowed on iOS.
  ///
  /// This field is ignored on Android because Android allows it by default.
  ///
  /// By default `allowsInlineMediaPlayback` is false.
  final bool allowsInlineMediaPlayback;

  /// Invoked when a page starts loading.
  final PageStartedCallback? onPageStarted;

  /// Invoked when a page has finished loading.
  ///
  /// This is invoked only for the main frame.
  ///
  /// When [onPageFinished] is invoked on Android, the page being rendered may
  /// not be updated yet.
  ///
  /// When invoked on iOS or Android, any JavaScript code that is embedded
  /// directly in the HTML has been loaded and code injected with
  /// [WebViewController.runJavascript] or [WebViewController.runJavascriptReturningResult] can assume this.
  final PageFinishedCallback? onPageFinished;

  /// Invoked when a page is loading.
  final PageLoadingCallback? onProgress;

  /// Invoked when a web resource has failed to load.
  ///
  /// This callback is only called for the main page.
  final WebResourceErrorCallback? onWebResourceError;

  /// Controls whether WebView debugging is enabled.
  ///
  /// Setting this to true enables [WebView debugging on Android](https://developers.google.com/web/tools/chrome-devtools/remote-debugging/).
  ///
  /// WebView debugging is enabled by default in dev builds on iOS.
  ///
  /// To debug WebViews on iOS:
  /// - Enable developer options (Open Safari, go to Preferences -> Advanced and make sure "Show Develop Menu in Menubar" is on.)
  /// - From the Menu-bar (of Safari) select Develop -> iPhone Simulator -> <your webview page>
  ///
  /// By default `debuggingEnabled` is false.
  final bool debuggingEnabled;

  /// A Boolean value indicating whether horizontal swipe gestures will trigger back-forward list navigations.
  ///
  /// This only works on iOS.
  ///
  /// By default `gestureNavigationEnabled` is false.
  final bool gestureNavigationEnabled;

  /// The value used for the HTTP User-Agent: request header.
  ///
  /// When null the platform's webview default is used for the User-Agent header.
  ///
  /// When the [WebView] is rebuilt with a different `userAgent`, the page reloads and the request uses the new User Agent.
  ///
  /// When [WebViewController.goBack] is called after changing `userAgent` the previous `userAgent` value is used until the page is reloaded.
  ///
  /// This field is ignored on iOS versions prior to 9 as the platform does not support a custom
  /// user agent.
  ///
  /// By default `userAgent` is null.
  final String? userAgent;

  /// A Boolean value indicating whether the WebView should support zooming
  /// using its on-screen zoom controls and gestures.
  ///
  /// *Note: On iOS [javascriptMode] must be set to
  /// [JavascriptMode.unrestricted] in order to set [zoomEnabled] to false
  ///
  /// By default 'zoomEnabled' is true
  final bool zoomEnabled;

  /// Which restrictions apply on automatic media playback.
  ///
  /// This initial value is applied to the platform's webview upon creation. Any following
  /// changes to this parameter are ignored (as long as the state of the [WebView] is preserved).
  ///
  /// The default policy is [AutoMediaPlaybackPolicy.require_user_action_for_all_media_types].
  final AutoMediaPlaybackPolicy initialMediaPlaybackPolicy;

  /// The background color of the [WebView].
  ///
  /// When `null` the platform's webview default background color is used. By
  /// default [backgroundColor] is `null`.
  final Color? backgroundColor;

  /// Creates a new web view.
  ///
  /// The web view can be controlled using a `WebViewController` that is passed to the
  /// `onWebViewCreated` callback once the web view is created.
  ///
  /// The `javascriptMode` and `autoMediaPlaybackPolicy` parameters must not be null.
  const WebView({
    Key? key,
    this.onWebViewCreated,
    this.initialUrl,
    this.initialCookies = const <WebViewCookie>[],
    this.javascriptMode = JavascriptMode.disabled,
    this.javascriptChannels,
    this.navigationDelegate,
    this.gestureRecognizers,
    this.onPageStarted,
    this.onPageFinished,
    this.onProgress,
    this.onWebResourceError,
    this.debuggingEnabled = false,
    this.gestureNavigationEnabled = false,
    this.userAgent,
    this.zoomEnabled = true,
    this.initialMediaPlaybackPolicy =
        AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
    this.allowsInlineMediaPlayback = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

/// Controls a [WebView].
///
/// A [WebViewController] instance can be obtained by setting the [WebView.onWebViewCreated]
/// callback for a [WebView] widget.
class WebViewController {
  final WebViewPlatformController _webViewPlatformController;

  final JavascriptChannelRegistry _javascriptChannelRegistry;
  late WebSettings _settings;

  WebView _widget;

  WebViewController._(
    this._widget,
    this._webViewPlatformController,
    this._javascriptChannelRegistry,
  ) {
    _settings = _webSettingsFromWidget(_widget);
  }

  /// Checks whether there's a back history item.
  ///
  /// Note that this operation is asynchronous, and it is possible that the "canGoBack" state has
  /// changed by the time the future completed.
  Future<bool> canGoBack() {
    return _webViewPlatformController.canGoBack();
  }

  /// Checks whether there's a forward history item.
  ///
  /// Note that this operation is asynchronous, and it is possible that the "canGoForward" state has
  /// changed by the time the future completed.
  Future<bool> canGoForward() {
    return _webViewPlatformController.canGoForward();
  }

  /// Clears all caches used by the [WebView].
  ///
  /// The following caches are cleared:
  ///	1. Browser HTTP Cache.
  ///	2. [Cache API](https://developers.google.com/web/fundamentals/instant-and-offline/web-storage/cache-api) caches.
  ///    These are not yet supported in iOS WkWebView. Service workers tend to use this cache.
  ///	3. Application cache.
  ///	4. Local Storage.
  ///
  /// Note: Calling this method also triggers a reload.
  Future<void> clearCache() async {
    await _webViewPlatformController.clearCache();
    return reload();
  }

  /// Accessor to the current URL that the WebView is displaying.
  ///
  /// If [WebView.initialUrl] was never specified, returns `null`.
  /// Note that this operation is asynchronous, and it is possible that the
  /// current URL changes again by the time this function returns (in other
  /// words, by the time this future completes, the WebView may be displaying a
  /// different URL).
  Future<String?> currentUrl() {
    return _webViewPlatformController.currentUrl();
  }

  /// Evaluates a JavaScript expression in the context of the current page.
  ///
  /// On Android returns the evaluation result as a JSON formatted string.
  ///
  /// On iOS depending on the value type the return value would be one of:
  ///
  ///  - For primitive JavaScript types: the value string formatted
  ///    (e.g JavaScript 100 returns '100').
  ///  - For JavaScript arrays of supported types: a string formatted NSArray
  ///    (e.g '(1,2,3), note that the string for NSArray is formatted and might
  ///    contain newlines and extra spaces.').
  ///  - Other non-primitive types are not supported on iOS and will complete
  ///    the Future with an error.
  ///
  /// The Future completes with an error if a JavaScript error occurred,
  /// or on iOS, if the type of the evaluated expression is
  /// not supported as described above.
  ///
  /// When evaluating JavaScript in a [WebView], it is best practice to wait for
  /// the [WebView.onPageFinished] callback. This guarantees all the JavaScript
  /// embedded in the main frame HTML has been loaded.
  @Deprecated('Use [runJavascript] or [runJavascriptReturningResult]')
  Future<String> evaluateJavascript(String javascriptString) {
    if (_settings.javascriptMode == JavascriptMode.disabled) {
      return Future<String>.error(FlutterError(
          'JavaScript mode must be enabled/unrestricted when calling evaluateJavascript.'));
    }
    return _webViewPlatformController.evaluateJavascript(javascriptString);
  }

  /// Return the horizontal scroll position, in WebView pixels, of this view.
  ///
  /// Scroll position is measured from left.
  Future<int> getScrollX() {
    return _webViewPlatformController.getScrollX();
  }

  /// Return the vertical scroll position, in WebView pixels, of this view.
  ///
  /// Scroll position is measured from top.
  Future<int> getScrollY() {
    return _webViewPlatformController.getScrollY();
  }

  /// Returns the title of the currently loaded page.
  Future<String?> getTitle() {
    return _webViewPlatformController.getTitle();
  }

  /// Goes back in the history of this WebView.
  ///
  /// If there is no back history item this is a no-op.
  Future<void> goBack() {
    return _webViewPlatformController.goBack();
  }

  /// Goes forward in the history of this WebView.
  ///
  /// If there is no forward history item this is a no-op.
  Future<void> goForward() {
    return _webViewPlatformController.goForward();
  }

  /// Loads the file located at the specified [absoluteFilePath].
  ///
  /// The [absoluteFilePath] parameter should contain the absolute path to the
  /// file as it is stored on the device. For example:
  /// `/Users/username/Documents/www/index.html`.
  ///
  /// Throws an ArgumentError if the [absoluteFilePath] does not exist.
  Future<void> loadFile(
    String absoluteFilePath,
  ) {
    assert(absoluteFilePath.isNotEmpty);
    return _webViewPlatformController.loadFile(absoluteFilePath);
  }

  /// Loads the Flutter asset specified in the pubspec.yaml file.
  ///
  /// Throws an ArgumentError if [key] is not part of the specified assets
  /// in the pubspec.yaml file.
  Future<void> loadFlutterAsset(String key) {
    assert(key.isNotEmpty);
    return _webViewPlatformController.loadFlutterAsset(key);
  }

  /// Loads the supplied HTML string.
  ///
  /// The [baseUrl] parameter is used when resolving relative URLs within the
  /// HTML string.
  Future<void> loadHtmlString(
    String html, {
    String? baseUrl,
  }) {
    assert(html.isNotEmpty);
    return _webViewPlatformController.loadHtmlString(
      html,
      baseUrl: baseUrl,
    );
  }

  /// Makes a specific HTTP request and loads the response in the webview.
  ///
  /// [WebViewRequest.method] must be one of the supported HTTP methods
  /// in [WebViewRequestMethod].
  ///
  /// If [WebViewRequest.headers] is not empty, its key-value pairs will be
  /// added as the headers for the request.
  ///
  /// If [WebViewRequest.body] is not null, it will be added as the body
  /// for the request.
  ///
  /// Throws an ArgumentError if [WebViewRequest.uri] has empty scheme.
  ///
  /// Android only:
  /// When making a POST request, headers are ignored. As a workaround, make
  /// the request manually and load the response data using [loadHTMLString].
  Future<void> loadRequest(WebViewRequest request) async {
    return _webViewPlatformController.loadRequest(request);
  }

  /// Loads the specified URL.
  ///
  /// If `headers` is not null and the URL is an HTTP URL, the key value paris in `headers` will
  /// be added as key value pairs of HTTP headers for the request.
  ///
  /// `url` must not be null.
  ///
  /// Throws an ArgumentError if `url` is not a valid URL string.
  Future<void> loadUrl(
    String url, {
    Map<String, String>? headers,
  }) async {
    _validateUrlString(url);
    return _webViewPlatformController.loadUrl(url, headers);
  }

  /// Reloads the current URL.
  Future<void> reload() {
    return _webViewPlatformController.reload();
  }

  /// Runs the given JavaScript in the context of the current page.
  /// If you are looking for the result, use [runJavascriptReturningResult] instead.
  /// The Future completes with an error if a JavaScript error occurred.
  ///
  /// When running JavaScript in a [WebView], it is best practice to wait for
  /// the [WebView.onPageFinished] callback. This guarantees all the JavaScript
  /// embedded in the main frame HTML has been loaded.
  Future<void> runJavascript(String javaScriptString) {
    if (_settings.javascriptMode == JavascriptMode.disabled) {
      return Future<void>.error(FlutterError(
          'JavaScript mode must be enabled/unrestricted when calling runJavascript.'));
    }
    return _webViewPlatformController.runJavascript(javaScriptString);
  }

  /// Runs the given JavaScript in the context of the current page,
  /// and returns the result.
  ///
  /// On Android returns the evaluation result as a JSON formatted string.
  ///
  /// On iOS depending on the value type the return value would be one of:
  ///
  ///  - For primitive JavaScript types: the value string formatted
  ///    (e.g JavaScript 100 returns '100').
  ///  - For JavaScript arrays of supported types: a string formatted NSArray
  ///    (e.g '(1,2,3), note that the string for NSArray is formatted and might
  ///    contain newlines and extra spaces.').
  ///
  /// The Future completes with an error if a JavaScript error occurred,
  /// or if the type the given expression evaluates to is unsupported.
  /// Unsupported values include certain non primitive types on iOS, as well as
  /// `undefined` or `null` on iOS 14+.
  ///
  /// When evaluating JavaScript in a [WebView], it is best practice to wait
  /// for the [WebView.onPageFinished] callback. This guarantees all the
  /// JavaScript embedded in the main frame HTML has been loaded.
  Future<String> runJavascriptReturningResult(String javaScriptString) {
    if (_settings.javascriptMode == JavascriptMode.disabled) {
      return Future<String>.error(FlutterError(
          'JavaScript mode must be enabled/unrestricted when calling runJavascriptReturningResult.'));
    }
    return _webViewPlatformController
        .runJavascriptReturningResult(javaScriptString);
  }

  /// Move the scrolled position of this view.
  ///
  /// The parameters `x` and `y` specify the amount of WebView pixels to scroll by horizontally and vertically respectively.
  Future<void> scrollBy(int x, int y) {
    return _webViewPlatformController.scrollBy(x, y);
  }

  /// Sets the WebView's content scroll position.
  ///
  /// The parameters `x` and `y` specify the scroll position in WebView pixels.
  Future<void> scrollTo(int x, int y) {
    return _webViewPlatformController.scrollTo(x, y);
  }

  Future<void> _updateJavascriptChannels(
      Set<JavascriptChannel>? newChannels) async {
    final Set<String> currentChannels =
        _javascriptChannelRegistry.channels.keys.toSet();
    final Set<String> newChannelNames = _extractChannelNames(newChannels);
    final Set<String> channelsToAdd =
        newChannelNames.difference(currentChannels);
    final Set<String> channelsToRemove =
        currentChannels.difference(newChannelNames);
    if (channelsToRemove.isNotEmpty) {
      await _webViewPlatformController
          .removeJavascriptChannels(channelsToRemove);
    }
    if (channelsToAdd.isNotEmpty) {
      await _webViewPlatformController.addJavascriptChannels(channelsToAdd);
    }
    _javascriptChannelRegistry.updateJavascriptChannelsFromSet(newChannels);
  }

  Future<void> _updateSettings(WebSettings newSettings) {
    final WebSettings update =
        _clearUnchangedWebSettings(_settings, newSettings);
    _settings = newSettings;
    return _webViewPlatformController.updateSettings(update);
  }

  Future<void> _updateWidget(WebView widget) async {
    _widget = widget;
    await _updateSettings(_webSettingsFromWidget(widget));
    await _updateJavascriptChannels(widget.javascriptChannels);
  }
}

class _PlatformCallbacksHandler implements WebViewPlatformCallbacksHandler {
  WebView _widget;

  _PlatformCallbacksHandler(this._widget);

  @override
  FutureOr<bool> onNavigationRequest({
    required String url,
    required bool isForMainFrame,
  }) async {
    final NavigationRequest request =
        NavigationRequest._(url: url, isForMainFrame: isForMainFrame);
    final bool allowNavigation = _widget.navigationDelegate == null ||
        await _widget.navigationDelegate!(request) ==
            NavigationDecision.navigate;
    return allowNavigation;
  }

  @override
  void onPageFinished(String url) {
    if (_widget.onPageFinished != null) {
      _widget.onPageFinished!(url);
    }
  }

  @override
  void onPageStarted(String url) {
    if (_widget.onPageStarted != null) {
      _widget.onPageStarted!(url);
    }
  }

  @override
  void onProgress(int progress) {
    if (_widget.onProgress != null) {
      _widget.onProgress!(progress);
    }
  }

  @override
  void onWebResourceError(WebResourceError error) {
    if (_widget.onWebResourceError != null) {
      _widget.onWebResourceError!(error);
    }
  }
}

class _WebViewState extends State<WebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  late JavascriptChannelRegistry _javascriptChannelRegistry;
  late _PlatformCallbacksHandler _platformCallbacksHandler;

  @override
  Widget build(BuildContext context) {
    return WebView.platform.build(
      context: context,
      onWebViewPlatformCreated: _onWebViewPlatformCreated,
      webViewPlatformCallbacksHandler: _platformCallbacksHandler,
      javascriptChannelRegistry: _javascriptChannelRegistry,
      gestureRecognizers: widget.gestureRecognizers,
      creationParams: _creationParamsfromWidget(widget),
    );
  }

  @override
  void didUpdateWidget(WebView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _assertJavascriptChannelNamesAreUnique();
    _controller.future.then((WebViewController controller) {
      _platformCallbacksHandler._widget = widget;
      controller._updateWidget(widget);
    });
  }

  @override
  void initState() {
    super.initState();
    _assertJavascriptChannelNamesAreUnique();
    _platformCallbacksHandler = _PlatformCallbacksHandler(widget);
    _javascriptChannelRegistry =
        JavascriptChannelRegistry(widget.javascriptChannels);
  }

  void _assertJavascriptChannelNamesAreUnique() {
    if (widget.javascriptChannels == null ||
        widget.javascriptChannels!.isEmpty) {
      return;
    }
    assert(_extractChannelNames(widget.javascriptChannels).length ==
        widget.javascriptChannels!.length);
  }

  void _onWebViewPlatformCreated(WebViewPlatformController? webViewPlatform) {
    final WebViewController controller = WebViewController._(
      widget,
      webViewPlatform!,
      _javascriptChannelRegistry,
    );
    _controller.complete(controller);
    if (widget.onWebViewCreated != null) {
      widget.onWebViewCreated!(controller);
    }
  }
}
