import 'package:flutter/material.dart';

class AppTheme {
  static Color background = HexColor.from("#ffffff");
  static Color foreground = HexColor.from("#1e1e1e");
  static Color buttonColor = HexColor.from("#f2f2f2");
  static Color buttonBorder = HexColor.from("#818181");
  static Color buttonHoverBorder = HexColor.from("#818181");
  static Color buttonTextColor = HexColor.from("#000000");
  static Color curvedTopBarDropShadowColor =
      HexColor.from("#000000").withOpacity(0.10);
  static Color stepBoxHoverColor = HexColor.from("#EF477B");
  static Color messagePanelBackground = HexColor.from("#1e1e1e");
  static Color messagePanelForeground = HexColor.from("#ffffff");
  static Color dividerColor = HexColor.from("#d3d3d3");
  static Color dashboardBackground = HexColor.from("#F1FEFF");
  static Color dashboardCardColor = HexColor.from("#F5F5F5");
  static Color dashboardCardHoverColor = HexColor.from("#E0E0E0");
  static Color dashboardCardTextColor = Colors.grey;
  static Color dashboardCardActiveBorderColor = Colors.grey.shade600;
  static Color categoryBackground = HexColor.from("#F0F0F0");
  static Color categoryForeground = HexColor.from("#A0A0A0");
  static Color storeBackground = HexColor.from("#FFFFFF");
  static Color appViewBackground = HexColor.from("#F5F5F5");
  static Color appViewTopBarColor = HexColor.from("#F0F0F0");
  static Color appViewIconBoxColor = HexColor.from("#FAFAFA");

  static TextStyle get fontBold => TextStyle(
        fontFamily: "Satoshi",
        fontWeight: FontWeight.bold,
        color: foreground,
      );

  static TextStyle get fontExtraBold => TextStyle(
        fontFamily: "Satoshi",
        fontWeight: FontWeight.w900,
        color: foreground,
      );

  static TextStyle fontSize(double size) => TextStyle(
        fontFamily: "Satoshi",
        fontSize: size,
        color: foreground,
      );
}

class InputDecorations {
  static final BorderRadius _borderRadius = BorderRadius.circular(10);

  static InputDecoration get outlinedInputDecoration => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      );

  static InputDecoration createOutlined({String? labelText, String? hintText}) {
    return outlinedInputDecoration.copyWith(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontFamily: "Sen",
        fontSize: 12,
      ),
    );
  }

  static InputDecoration createUnderLined(
      {String? labelText, String? hintText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontFamily: "Sen",
        fontSize: 12,
      ),
    );
  }
}

class HomePageTheme {
  HomePageTheme._();

  static Color background = HexColor.from("#131316");
  static Color foreground = HexColor.from("#d3d3d3");
  static Color inactive = HexColor.from("#E9E9E9");
  static Color hover = HexColor.from("#D6D6D6");
  static Color navBarBackground = HexColor.from("#19191B");
  static Color navBarHoverBackground = HexColor.from("#29292B");
  static Color navBarBorder = HexColor.from("#303032");
  static Color navHoverColor = HexColor.from("#89898C");
  static Color navButtonColor = HexColor.from("#272729");
  static Color navButtonBorder = HexColor.from("#D3D3D3");
  static Color bentoContainerBackground = HexColor.from("#1D1C20");
  static Color bentoContainerBorder = HexColor.from("#2D2C30");

  static TextStyle get fontBold => TextStyle(
        fontFamily: "Satoshi",
        fontWeight: FontWeight.bold,
        color: foreground,
      );

  static TextStyle get fontExtraBold => TextStyle(
        fontFamily: "Satoshi",
        fontWeight: FontWeight.w900,
        color: foreground,
      );

  static TextStyle fontSize(double size) => TextStyle(
        fontFamily: "Satoshi",
        fontSize: size,
        color: foreground,
      );
}

extension ConfigurableTextStyle on TextStyle {
  TextStyle withColor(Color color) {
    return copyWith(
      color: color,
    );
  }

  TextStyle useSen() {
    return copyWith(
      fontFamily: "Sen",
    );
  }

  TextStyle makeBold() {
    return copyWith(
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle makeItalic() {
    return copyWith(
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle makeExtraBold() {
    return copyWith(
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle makeMedium() {
    return copyWith(
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle fontSize(double size) {
    return copyWith(
      fontSize: size,
    );
  }
}

extension HexColor on Color {
  static Color from(String hexColor) {
    hexColor = hexColor.replaceAll("0x", "");
    hexColor = hexColor.replaceAll("#", "");
    hexColor = hexColor.toUpperCase();
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
