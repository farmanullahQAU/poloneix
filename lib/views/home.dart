import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poloniex_app/controller.dart';
import 'package:poloniex_app/views/chart_view.dart';
import 'package:poloniex_app/views/highlight_screen.dart';

class PoloniexApp extends StatelessWidget {
  final WebSocketController webSocketController =
      Get.put(WebSocketController());

  PoloniexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poloniex App'),
      ),
      body: Column(
        children: [
          const PriceChartView(),
          StreamBuilder(
            stream: webSocketController.ticker.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.hasData) {
                final ticker = snapshot.data;

                return TradeHighlightScreen(price: ticker!.last.price);
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
