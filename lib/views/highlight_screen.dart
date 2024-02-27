import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poloniex_app/controller.dart';

class TradeHighlightScreen extends GetView<WebSocketController> {
  final double price;

  const TradeHighlightScreen({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: context.width * 0.5,
          child: TextField(
            onSubmitted: controller.onUserPriceChange,
            onChanged: controller.onUserPriceChange,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: controller.userPriceController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.price_change),
                border: OutlineInputBorder()),
          ),
        ),
        GetBuilder<WebSocketController>(
            id: "highlight",
            builder: (_) {
              IconData icon;
              Color color;
//it will be handle properly not good way to put here
              if ((controller.userPrice) < price) {
                icon = Icons.arrow_upward;
                color = Colors.green;
              } else if ((controller.userPrice) > price) {
                icon = Icons.arrow_downward;
                color = Colors.red;
              } else {
                icon = Icons.arrow_forward;
                color = Colors.black;
              }
              return Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: color,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        children: [
                          Text('$price',
                              style: context.textTheme.titleLarge
                                  ?.copyWith(color: color)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
