import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:poloniex_app/models/Ticker_model.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketController extends GetxController {
  double userPrice = 0.0;
  TextEditingController userPriceController = TextEditingController(text: "0");
  final _socket = Rxn<IOWebSocketChannel>();
  final ticker = RxList<TickerModel>();

  @override
  void onInit() {
    subscribeToTicker("BTCUSDTPERP"); // Subscribe to a ticker
    super.onInit();
  }

  Future<void> subscribeToTicker(String symbol) async {
    try {
      _socket.value = await connectWebSocket();

      _socket.value?.stream.listen((data) {
        try {
          final Map<String, dynamic> map = jsonDecode(data);
          if (map['subject'] == 'ticker') {
            if (map['data'] != null) {
              final tickerModel = TickerModel.fromJson(map["data"]);
              ticker.add(tickerModel);

              print(map);
            }
          } else {
            log('Unknown message: $map');
          }
        } catch (err, stackTrace) {
          log('Error parsing message: $err\n$stackTrace');
        }
      }, onError: (error, stackTrace) {
        log(' connection error: $error\n$stackTrace');
      });

      final subscriptionMessage = jsonEncode({
        "id": 1545910660740,
        "type": "subscribe",
        "topic": "/contractMarket/ticker:$symbol",
        "response": true
      });

      _socket.value?.sink.add(subscriptionMessage);
      log('Subscription message sent: $subscriptionMessage');
    } catch (error, stackTrace) {
      log('Error connecting to WebSocket: $error\n$stackTrace');
    }
  }

  Future<String> _fetchTokenAndConnect() async {
    try {
      final response = await http.post(
        Uri.parse('https://futures-api.poloniex.com/api/v1/bullet-public'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final token = jsonResponse['data']['token'];
        return token;
      } else {
        throw Exception('Failed to fetch token: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Error fetching token: $e\n$stackTrace');
      return "";
    }
  }

  Future<IOWebSocketChannel> connectWebSocket() async {
    try {
      final token = await _fetchTokenAndConnect();
      log('WebSocket token: $token');

      final url = 'wss://futures-apiws.poloniex.com/endpoint?token=$token';
      final socket = IOWebSocketChannel.connect(Uri.parse(url),
          pingInterval: const Duration(seconds: 3));
      log('WebSocket connected: $url');
      return socket;
    } catch (error, stackTrace) {
      log('Error connecting to WebSocket: $error\n$stackTrace');
      rethrow;
    }
  }

  @override
  void onClose() {
    _socket.value?.sink.close(); //close the socket if controller stashed
    super.onClose();
  }

  void onPriceSubmit(String value) {
    if (value.isNotEmpty) {
      userPrice = double.tryParse(value) ?? 0;
      update(["highlight"]);
    }
  }
}
