part of responsive_sizer;

/// Provides `Context`, `Orientation`, and `ScreenType` parameters to the builder function
typedef ResponsiveBuilderType = Widget Function(
  BuildContext,
  Orientation,
  ScreenType,
);

/// A widget that gets the device's details like orientation and constraints
///
/// Usage: Wrap MaterialApp with this widget
class ResponsiveSizer extends StatelessWidget {
  const ResponsiveSizer(
      {Key? key,
      required this.builder,
      this.maxMobileWidth = 599,
      this.maxTabletWidth = 1024,
      this.maxDesktopWidth = 1920,
      this.maxRetinaWidth = 2460})
      : super(key: key);

  /// Builds the widget whenever the orientation changes
  final ResponsiveBuilderType builder;

  /// This is the breakpoint used to determine whether the device is
  /// a mobile device or a tablet.
  ///
  /// If the `MediaQuery`'s width **in portrait mode** is less than or equal
  /// to `maxMobileWidth`, the device is in a mobile device
  final double maxMobileWidth;

  /// This is the breakpoint used to determine whether the device is
  /// a tablet or a desktop.
  ///
  /// If the `MediaQuery`'s width **in portrait mode** is
  /// less than or equal to `maxTabletWidth`, the device is in a tablet device
  final double maxTabletWidth;

  /// This is the breakpoint used to determine whether the device screen type is desktop

  final double maxDesktopWidth;

  /// This is the breakpoint used to determine whether the device screen type is retina
  final double maxRetinaWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        Device.setScreenSize(context, constraints, orientation, maxMobileWidth,
            maxTabletWidth, maxDesktopWidth, maxRetinaWidth);

        if (constraints.maxWidth == 0 || constraints.maxHeight == 0) {
          return const SizedBox();
        }
        return builder(context, orientation, Device.screenType);
      });
    });
  }
}
