// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';

class Permission {
  PermissionStatus status;
  final int value;
  final String name;

  Permission(
    this.value,
    this.name, {
    this.status = PermissionStatus.notDetermined,
  });

  PermissionStatus get getStatus => status;

  bool get isAuthorized => status == PermissionStatus.authorized;
  bool get isDenied => status == PermissionStatus.denied;
  bool get isDetermined => status == PermissionStatus.notDetermined;
  bool get isRestricted => status == PermissionStatus.restricted;
  set setStatus(PermissionStatus status) {
    this.status = status;
  }

  request() {
    return AlertDialog(
      title: Text('Configuración'),
      content: Text("Se solicita el permiso de '$name'."),
      actions: [
        TextButton(
          onPressed: () {
            status = PermissionStatus.notDetermined;
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            status = PermissionStatus.denied;
          },
          child: Text('Denegar'),
        ),
        TextButton(
          onPressed: () {
            status = PermissionStatus.authorized;
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}

class PermissionHandler {
  static final PermissionHandler getInstance = PermissionHandler._internal();

  final Map<Permission, PermissionStatus> _statuses = {};

  PermissionHandler._internal();

  request(Permission permission) {
    return AlertDialog(
      title: Text('Configuración'),
      content:
          Text('This will reset your device to its default factory settings.'),
      actions: [
        TextButton(
          onPressed: () {
            permission.setStatus = PermissionStatus.notDetermined;
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            permission.setStatus = PermissionStatus.denied;
          },
          child: Text('Denegar'),
        ),
        TextButton(
          onPressed: () {
            permission.setStatus = PermissionStatus.authorized;
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }

  /// Check a [permission] and return a [Future] with the result
  static Future<bool> checkPermission(Permission permission) {
    return Future.value(false);
  }

  /// Get Android/iOs permission status
  static Future<PermissionStatus> getPermissionStatus(
      Permission permission) async {
    return PermissionHandler.getInstance._statuses.containsKey(permission)
        ? Future.value(permission.getStatus)
        : Future.value(PermissionStatus.notDetermined);
  }

  /// Open app settings on Android and iOS
  static Future<bool> openSettings() {
    return Future.value(false);
  }

  /// Request a [permission] and return a [Future] with the result
  static Future<PermissionStatus> requestPermission(Permission permission) {
    return Future.value(PermissionStatus.denied);
  }
}

class Permissions {
  // Microphone
  static final Permission RecordAudio = Permission(1, "Grabación de audio");

  // Camera
  static final Permission Camera = Permission(2, "Cámara");

  // Read External Storage (Android)
  static final Permission ReadExternalStorage =
      Permission(3, "Lectura en almacenamiento externo");

  // Write External Storage (Android)
  static final Permission WriteExternalStorage =
      Permission(4, "Escritura en almacenamiento externo");

  // Access Coarse Location (Android) / When In Use iOS
  static final Permission AccessCoarseLocation =
      Permission(5, "Ubicación por aproximación");

  // Access Fine Location (Android) / When In Use iOS
  static final Permission AccessFineLocation =
      Permission(6, "Ubicación por GPS");

  // Access Fine Location (Android) / When In Use iOS
  static final Permission WhenInUseLocation =
      Permission(7, "Grabación de audio");

  // Access Fine Location (Android) / Always Location iOS
  static final Permission AlwaysLocation = Permission(8, "Localización");

  // Write contacts (Android) / Contacts iOS
  static final Permission WriteContacts =
      Permission(9, "Adicionar y Modificar contactos");

  // Read contacts (Android) / Contacts iOS
  static final Permission ReadContacts =
      Permission(10, "Acceder a los contactos");

  static final List<Permission> permissions = [
    RecordAudio,
    Camera,
    ReadExternalStorage,
    WriteExternalStorage,
    AccessCoarseLocation,
    AccessFineLocation,
    WhenInUseLocation,
    AlwaysLocation,
    WriteContacts,
    ReadContacts
  ];

  static Permission? byValue(int value) {
    for (var element in Permissions.permissions) {
      if (element.value == value) return element;
    }
    return null;
  }

  static bool exists(int value) => byValue(value) != null;
}

enum PermissionStatus {
  notDetermined,
  restricted,
  denied,
  authorized,
}
