import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double getHorizontalPadding(BuildContext context) {
    if (isDesktop(context)) return 48;
    if (isTablet(context)) return 32;
    return 16;
  }

  static double getMaxContentWidth(BuildContext context) {
    if (isDesktop(context)) return 1200;
    if (isTablet(context)) return 800;
    return double.infinity;
  }

  static EdgeInsets getContentPadding(BuildContext context) {
    final horizontal = getHorizontalPadding(context);
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: 16);
  }

  static int getGridColumns(BuildContext context) {
    if (isDesktop(context)) return 2;
    if (isTablet(context)) return 2;
    return 1;
  }

  static double getCardElevation(BuildContext context) {
    return isDesktop(context) ? 2 : 1;
  }

  static double getTextScale(BuildContext context) {
    if (isMobile(context)) return 1.0;
    if (isTablet(context)) return 1.05;
    return 1.1;
  }
}

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ResponsiveHelper.getMaxContentWidth(context),
        ),
        child: child,
      ),
    );
  }
}
