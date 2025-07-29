import 'dart:ui';

extension TextLeadingDistributionParser on TextLeadingDistribution {
  static TextLeadingDistribution get even => TextLeadingDistribution.even;

  static TextLeadingDistribution get proportional =>
      TextLeadingDistribution.proportional;

  static TextLeadingDistribution parse(dynamic value) {
    if (value is TextLeadingDistribution) {
      return value;
    } else if (value is String) {
      switch (value) {
        case "proportional":
          return TextLeadingDistribution.proportional;
        case "even":
          return TextLeadingDistribution.even;
      }
    }
    return TextLeadingDistribution.proportional;
  }

  static String value(TextLeadingDistribution? value) {
    return value != null
        ? value.toString().replaceAll("TextLeadingDistribution.", "")
        : "proportional";
  }
}
