import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../marker.dart';
import '../plot_band.dart';
import '../renderers/spark_area_renderer.dart';
import '../theme.dart';
import '../trackball/spark_chart_trackball.dart';
import '../trackball/trackball_renderer.dart';
import '../utils/enum.dart';
import '../utils/helper.dart';

/// This class renders an area spark chart. The [SfSparkAreaChart] is a
/// very small chart, typically drawn without axis ticks and labels.
/// It presents the general shape of data in a simple and highly condensed way.
///
/// To render an area spark chart, create the instance of [SfSparkAreaChart].
/// Set the value for `data` property which of type `List<num>`.
/// Now, it shows the filled area to represent the provided data.
///
/// It provides option to customize its appearance with the properties
/// such as [color], [borderWidth], [borderColor]. To highlight the provided
/// data, use either its [marker] property or its data label property.
/// To highlight the data point, which is tapped, use its [trackball] property.
/// To highlight the particular region along with the vertical value,
/// use its [plotBand] property.

class SfSparkAreaChart extends StatefulWidget {
  /// Creates a spark area chart for the provided set of data with its default view.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      data: <double>[18, 24, 30, 14, 28],
  ///       )
  ///    ),
  ///  );
  /// }
  /// ```
  SfSparkAreaChart({
    Key? key,
    List<num>? data,
    this.plotBand,
    this.borderWidth = 0,
    this.borderColor,
    this.color,
    this.isInversed = false,
    this.axisCrossesAt = 0,
    this.axisLineColor,
    this.axisLineWidth = 2,
    this.axisLineDashArray,
    this.highPointColor,
    this.lowPointColor,
    this.negativePointColor,
    this.firstPointColor,
    this.lastPointColor,
    this.marker,
    this.labelDisplayMode,
    this.labelStyle,
    this.trackball,
  }) : _sparkChartDataDetails = SparkChartDataDetails(data: data),
       super(key: key);

  /// Creates the spark area chart for the provided set of data with its default view.
  ///
  /// The difference between the default constructor and this constructor is,
  /// in the default constructor uses its data property to get the input data value.
  /// The `data` property of the default constructor is of type `List<num>`.
  ///
  /// The custom constructor uses its [dataCount], [xValueMapper] and
  /// [yValueMapper] to get the input data.
  ///
  /// The [dataCount] property allows declaring the total data count going to be
  /// displayed in the chart.
  ///
  /// The [xValueMapper] returns the x- value of the corresponding data point.
  /// The [xValueMapper] allows providing num, DateTime, or string as x-value.
  ///
  /// The [yValueMapper] returns the y-value of the corresponding data point.
  ///
  /// ```dart
  /// class SalesData {
  ///    SalesData(this.month, this.sales);
  ///    final String month;
  ///    final double sales;
  /// }
  ///
  ///  List<SalesData> data;
  ///
  /// @override
  /// void initState() {
  ///  super.initState();
  ///  data = <SalesData>[
  ///    SalesData('Jan', 200),
  ///    SalesData('Feb', 215),
  ///    SalesData('Mar', 380),
  ///    SalesData('Apr', 240),
  ///    SalesData('May', 280),
  ///  ];
  /// }
  ///
  ///  @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart.custom(
  ///         dataCount: 5,
  ///          xValueMapper: (int index) => data[index].month,
  ///          yValueMapper: (int index) => data[index].sales
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```

  SfSparkAreaChart.custom({
    Key? key,

    /// Data count for the spark charts.
    int? dataCount,

    /// Specifies the x-value mapping field.
    SparkChartIndexedValueMapper<dynamic>? xValueMapper,

    /// Specifies the y-value mapping field.
    SparkChartIndexedValueMapper<num>? yValueMapper,
    this.plotBand,
    this.borderWidth = 2,
    this.borderColor,
    this.color,
    this.isInversed = false,
    this.axisCrossesAt = 0,
    this.axisLineColor,
    this.axisLineWidth = 2,
    this.axisLineDashArray,
    this.highPointColor,
    this.lowPointColor,
    this.negativePointColor,
    this.firstPointColor,
    this.lastPointColor,
    this.marker,
    this.labelDisplayMode,
    this.labelStyle,
    this.trackball,
  }) : _sparkChartDataDetails = SparkChartDataDetails(
         dataCount: dataCount,
         xValueMapper: xValueMapper,
         yValueMapper: yValueMapper,
       ),
       super(key: key);

  /// Inverts the axis from right to left.
  ///
  /// In the spark chart, the provided set of data are rendered from left to
  /// right by default and can be inverted to render the data points
  /// from right to left.
  ///
  /// Defaults to `false`.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      isInversed: true,
  ///      data: <double>[18, 24, 30, 14, 28],
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final bool isInversed;

  /// Customize the axis position based on the provided y-value.The axis line is
  /// rendered on the minimum y-value and can be repositioned to required y-value.
  ///
  /// Defaults to `0`.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      axisCrossesAt: 14,
  ///      data: <double>[18, 24, 30, 14, 28],
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final double axisCrossesAt;

  /// Customizes the width of the axis line.
  ///
  /// Defaults to `2`.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      axisLineWidth: 4,
  ///      data: <double>[18, 24, 30, 14, 28],
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final double axisLineWidth;

  /// Customizes the color of the axis line.
  /// Colors.transparent can be set to [axisLineColor] to hide the axis line.
  ///
  /// Defaults to null.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      axisLineColor: Colors.red,
  ///      data: <double>[18, 24, 30, 14, 28],
  ///       )
  ///     ),
  ///   );
  /// }
  /// ```
  final Color? axisLineColor;

  /// Dashes of the axis line. Any number of values can be provided on the list.
  /// Odd value is considered as rendering size and even value is considered a gap.
  ///
  /// Defaults to `null`.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      axisLineDashArray: <double>[2,2],
  ///      data: <double>[18, 24, 30, 14, 28],
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final List<double>? axisLineDashArray;

  /// Customizes the [marker] color of the highest data point.
  ///
  /// When the high data point is the first or last data point of the provided
  /// data set, then either the first or last point color gets applied.
  ///
  /// Defaults to `null`.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
  ///      highPointColor: Colors.red,
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final Color? highPointColor;

  /// Customizes the [marker] color of the lowest data point.
  ///
  /// When the lowest data point is the first or last data point of the
  /// provided data set, then either the first or last point color gets applied.
  ///
  /// Defaults to `null`.
  ///
  /// ```dart
  /// @override
  ///  Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
  ///      lowPointColor: Colors.red,
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final Color? lowPointColor;

  /// Customizes the marker color of negative data point and data point value
  /// less than the [axisCrossesAt] value.
  ///
  /// If the negative data point is either the high or low, first or last data
  /// point, then priority will be given to those colors.
  ///
  /// Defaults to `null`.
  ///
  /// ```dart
  /// @override
  ///  Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
  ///      negativePointColor: Colors.red,
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final Color? negativePointColor;

  /// Customizes the [marker] color of the first data point.
  ///
  /// If the first data point is either the high data point or low data point,
  /// then the priority will be given to firstPointColor property.
  ///
  /// Defaults to `null`.
  ///
  /// ```dart
  /// @override
  ///  Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
  ///      firstPointColor: Colors.red,
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final Color? firstPointColor;

  /// Customizes the [marker] color of the last data point.
  ///
  /// If the last data point is either the high data point or low data point,
  /// then the priority will be given to lastPointColor property.
  ///
  /// Defaults to `null`.
  ///
  /// ```dart
  /// @override
  ///  Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
  ///      lastPointColor: Colors.red,
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final Color? lastPointColor;

  /// Customizes the spark area chart color.
  ///
  /// Defaults to null.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      color: Colors.blue,
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final Color? color;

  /// Render plot band.
  ///
  /// Plot band is also known as strip-line, which is used to shade the different
  /// ranges in plot area with different colors to improve the readability
  /// of the chart.
  ///
  /// Plot bands are drawn based on the axis.
  ///
  /// Provides the property of `start`, `end`, `color`, `borderColor`, and
  /// `borderWidth` to customize the appearance.
  ///
  /// Defaults to `null`.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      plotBand: SparkChartPlotBand(start: 15, end: 25)
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final SparkChartPlotBand? plotBand;

  /// Customizes the border width of the spark area chart.
  /// The border will be rendered on the top of the spark area chart.
  /// To render the border, both the border width and border color property
  /// needs to be set.
  ///
  /// Defaults to `0`.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      borderWidth: 2,
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final double borderWidth;

  /// Customizes the border color of the spark area chart.
  /// The border will be rendered on the top of the spark area chart.
  /// To render the border, both the [borderWidth] and borderColor property
  /// needs to be set.
  ///
  /// Defaults to `null`.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      borderColor: Colors.red
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final Color? borderColor;

  /// Enables and customizes the markers.
  ///
  /// Markers are used to provide information about the exact point location.
  /// You can add a shape to adorn each data point. Markers can be enabled by
  /// using the `displayMode` property of [SparkChartMarker].
  ///
  /// Provides the options of [color], [borderWidth], [borderColor] and `shape`
  /// of the marker to customize the appearance.
  ///
  /// Defaults to `null`.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all)
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```

  final SparkChartMarker? marker;

  /// Enables the data labels.
  ///
  /// Data labels are used to provide information about the exact point location
  /// and its value.
  ///
  /// * [SparkChartLabelDisplayMode.all] enables the data label for all the data
  /// points.
  /// * [SparkChartLabelDisplayMode.none] disables the data labels.
  /// * [SparkChartLabelDisplayMode.high] displays the data label on highest
  /// data point.
  /// * [SparkChartLabelDisplayMode.low] displays the data label on lowest
  /// data point.
  /// * [SparkChartLabelDisplayMode.first] displays the data label on first
  /// data point.
  /// * [SparkChartLabelDisplayMode.last] displays the data label on first
  /// data point.
  ///
  /// Also refer [SparkChartLabelDisplayMode].
  ///
  /// Defaults to `SparkChartDisplayMode.none`.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      labelDisplayMode: SparkChartLabelDisplayMode.high,
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final SparkChartLabelDisplayMode? labelDisplayMode;

  /// Customizes the data label text style.
  ///
  /// Using the [TextStyle], add style data labels.
  ///
  /// Defaults to null.
  ///
  /// Also refer [TextStyle].
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      labelStyle: TextStyle(fontStyle: FontStyle.italic)
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final TextStyle? labelStyle;

  /// Enables and customizes the trackball.
  ///
  /// Trackball feature displays the tooltip for the data points that are closer
  /// to the point where you touch on the chart area. This feature can be
  /// enabled by creating an instance of [SparkChartTrackball].
  ///
  /// Provides option to customizes the `activationMode`, `width`, `color`,
  /// `labelStyle`, `backgroundColor`, `borderColor`, `borderWidth`.
  ///
  /// Defaults to `null`.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    body: Center(
  ///        child: SfSparkAreaChart(
  ///      trackball:
  ///          SparkChartTrackball(activationMode: SparkChartActivationMode.tap)
  ///       )
  ///     ),
  ///  );
  /// }
  /// ```
  final SparkChartTrackball? trackball;

  /// Specifies the spark chart data details.
  final SparkChartDataDetails _sparkChartDataDetails;

  @override
  State<StatefulWidget> createState() {
    return _SfSparkAreaChartState();
  }
}

/// Represents the state class for spark area widget.
class _SfSparkAreaChartState extends State<SfSparkAreaChart> {
  /// Specifies the theme of the chart.
  late SfSparkChartThemeData _chartThemeData;

  /// Specifies the series screen coordinate points.
  late List<Offset> _coordinatePoints;

  /// Specifies the series data points.
  late List<SparkChartPoint> _dataPoints;

  SfSparkChartThemeData _updateThemeData(BuildContext context) {
    SfSparkChartThemeData chartThemeData = SfSparkChartTheme.of(context);
    final ThemeData theme = Theme.of(context);
    final SfSparkChartThemeData effectiveChartThemeData = SparkChartThemeData(
      context,
    );
    chartThemeData = chartThemeData.copyWith(
      color:
          widget.color ?? chartThemeData.color ?? effectiveChartThemeData.color,
      axisLineColor:
          widget.axisLineColor ??
          chartThemeData.axisLineColor ??
          effectiveChartThemeData.axisLineColor,
      markerFillColor:
          chartThemeData.markerFillColor ??
          effectiveChartThemeData.markerFillColor,
      dataLabelBackgroundColor:
          chartThemeData.dataLabelBackgroundColor ??
          effectiveChartThemeData.dataLabelBackgroundColor,
      tooltipColor:
          chartThemeData.tooltipColor ?? effectiveChartThemeData.tooltipColor,
      trackballLineColor:
          chartThemeData.trackballLineColor ??
          effectiveChartThemeData.trackballLineColor,
      tooltipLabelColor:
          chartThemeData.tooltipLabelColor ??
          effectiveChartThemeData.tooltipLabelColor,
      dataLabelTextStyle: theme.textTheme.bodySmall!
          .copyWith(color: Colors.transparent)
          .merge(chartThemeData.dataLabelTextStyle)
          .merge(widget.labelStyle),
      trackballTextStyle: theme.textTheme.bodySmall
          ?.copyWith(
            color:
                widget.trackball?.color ??
                chartThemeData.tooltipLabelColor ??
                effectiveChartThemeData.tooltipLabelColor,
          )
          .merge(chartThemeData.trackballTextStyle)
          .merge(widget.trackball?.labelStyle),
    );
    return chartThemeData;
  }

  /// Called when this object is inserted into the tree.
  ///
  /// The framework will call this method exactly once for each State object it creates.
  ///
  /// Override this method to perform initialization that depends on the location at
  /// which this object was inserted into the tree or on the widget used to configure this object.
  ///
  /// * In [initState], subscribe to the object.

  @override
  void initState() {
    _coordinatePoints = <Offset>[];
    _dataPoints = <SparkChartPoint>[];
    super.initState();
  }

  /// Called whenever the widget configuration changes.
  ///
  /// If the parent widget rebuilds and request that this location in the tree update to display a new widget with the same [runtimeType] and [Widget.key],
  /// the framework will update the widget property of this [State] object to refer to the new widget and then call this method with the previous widget as an argument.
  ///
  /// Override this method to respond when the widget changes.
  ///
  /// The framework always calls [build] after calling [didUpdateWidget], which means any calls to [setState] in [didUpdateWidget] are redundant.
  ///
  /// * In [didUpdateWidget] unsubscribe from the old object and subscribe to the new one if the updated widget configuration requires replacing the object.

  @override
  void didUpdateWidget(SfSparkAreaChart oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  /// Called when a dependency of this [State] object changes.
  ///
  /// For example, if the previous call to [build] referenced an [InheritedWidget] that later changed,
  /// the framework would call this method to notify this object about the change.
  ///
  /// This method is also called immediately after [initState]. It is safe to call [BuildContext.dependOnInheritedWidgetOfExactType] from this method.

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Describes the part of the user interface represented by this widget.
  ///
  /// The framework calls this method in a number of different situations. For example:
  ///
  /// * After calling [initState].
  /// * After calling [didUpdateWidget].
  /// * After receiving a call to [setState].
  /// * After a dependency of this [State] object changes.

  @override
  Widget build(BuildContext context) {
    _chartThemeData = _updateThemeData(context);
    if (widget.marker != null &&
        widget.marker!.displayMode != SparkChartMarkerDisplayMode.none) {
      final double padding = widget.marker!.size / 2;
      return RepaintBoundary(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: _getSparkAreaChart(),
        ),
      );
    } else {
      return RepaintBoundary(child: _getSparkAreaChart());
    }
  }

  /// Method to return the spark area chart widget.
  Widget _getSparkAreaChart() {
    return SparkChartContainer(
      child: Stack(
        children: <Widget>[
          SfSparkAreaChartRenderObjectWidget(
            data: widget._sparkChartDataDetails.data,
            dataCount: widget._sparkChartDataDetails.dataCount,
            xValueMapper: widget._sparkChartDataDetails.xValueMapper,
            yValueMapper: widget._sparkChartDataDetails.yValueMapper,
            isInversed: widget.isInversed,
            axisCrossesAt: widget.axisCrossesAt,
            axisLineColor: _chartThemeData.axisLineColor,
            axisLineWidth: widget.axisLineWidth,
            axisLineDashArray: widget.axisLineDashArray,
            highPointColor: widget.highPointColor,
            lowPointColor: widget.lowPointColor,
            firstPointColor: widget.firstPointColor,
            lastPointColor: widget.lastPointColor,
            negativePointColor: widget.negativePointColor,
            color: _chartThemeData.color,
            borderColor: widget.borderColor,
            borderWidth: widget.borderWidth,
            plotBand: widget.plotBand,
            marker: widget.marker,
            labelDisplayMode: widget.labelDisplayMode,
            labelStyle: _chartThemeData.dataLabelTextStyle,
            themeData: _chartThemeData,
            sparkChartDataDetails: widget._sparkChartDataDetails,
            dataPoints: _dataPoints,
            coordinatePoints: _coordinatePoints,
          ),
          SparkChartTrackballRenderer(
            trackball: widget.trackball,
            coordinatePoints: _coordinatePoints,
            dataPoints: _dataPoints,
            themeData: _chartThemeData,
            sparkChart: widget,
          ),
        ],
      ),
    );
  }
}
