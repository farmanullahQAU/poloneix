import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poloniex_app/controller.dart';
import 'package:poloniex_app/models/Ticker_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceChartView extends GetView<WebSocketController> {
  const PriceChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
            enablePinching: true,
          ),
          primaryXAxis: DateTimeAxis(
            dateFormat: DateFormat.Hm(),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            majorGridLines: const MajorGridLines(width: 0),
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            minorGridLines: const MinorGridLines(width: 0),
          ),
          primaryYAxis: const NumericAxis(
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0),
            labelFormat: "\$ {value}", // we have to show the dollar sign
          ),
          series: <CartesianSeries>[
            LineSeries<TickerModel, DateTime>(
              dataSource: controller.ticker.toList(),
              xValueMapper: (TickerModel sales, _) {
                return sales.ts;
              },
              yValueMapper: (TickerModel sales, _) {
                return sales.price.toDouble();
              },
            ),
          ],
        ),
      ),
    );
  }
}
