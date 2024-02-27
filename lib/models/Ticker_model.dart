class TickerModel {
  String symbol;
  int sequence;
  String side;
  int size;
  double price;
  int bestBidSize;
  double bestBidPrice;
  double bestAskPrice;
  String tradeId;
  DateTime ts;
  int bestAskSize;

  TickerModel({
    required this.symbol,
    required this.sequence,
    required this.side,
    required this.size,
    required this.price,
    required this.bestBidSize,
    required this.bestBidPrice,
    required this.bestAskPrice,
    required this.tradeId,
    required this.ts,
    required this.bestAskSize,
  });

  factory TickerModel.fromJson(Map<String, dynamic> json) {
    return TickerModel(
      symbol: json['symbol'],
      sequence: json['sequence'],
      side: json['side'],
      size: json['size'],
      price: json['price'],
      bestBidSize: json['bestBidSize'],
      bestBidPrice: double.parse(json['bestBidPrice']),
      bestAskPrice: double.parse(json['bestAskPrice']),
      tradeId: json['tradeId'],
      ts: DateTime.fromMicrosecondsSinceEpoch((json['ts'] ~/ 1000)),
      // ts: json['ts'],
      // ts: DateTime.parse(])
      bestAskSize: json['bestAskSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'sequence': sequence,
      'side': side,
      'size': size,
      'price': price,
      'bestBidSize': bestBidSize,
      'bestBidPrice': bestBidPrice,
      'bestAskPrice': bestAskPrice,
      'tradeId': tradeId,
      'ts': ts,
      'bestAskSize': bestAskSize,
    };
  }
}
