enum GlobalViewMode {
  visible, // Widget is visible but not editable
  hidden, // Widget is hidden
  enabled, // Widget is visible and editable
  disabled, // Widget is editable but is hidden
}

class ViewMode extends Object {
  GlobalViewMode mode = GlobalViewMode.visible;

  ViewMode(String modeOfView) {
    for (var element in GlobalViewMode.values) {
      if (element.name == modeOfView) mode = element;
    }
  }
  factory ViewMode.from(String modeOfView) {
    return ViewMode(modeOfView);
  }
  factory ViewMode.fromOther(GlobalViewMode modeOfView) {
    return ViewMode(modeOfView.name);
  }

  @override
  toString() {
    return mode.name;
  }
}
