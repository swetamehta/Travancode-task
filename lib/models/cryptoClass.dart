class CryptoClass {
  String id, name, symbol;
  double priceChanged24H, marketCap;

  CryptoClass.fromJson(Map<String, dynamic> data) {
    this.id = data['id']?.toString();
    this.name = data['name']?.toString();
    this.symbol = data['symbol']?.toString();

    try {
      var percent_change_24h = data['quote']['USD']['percent_change_24h'];
      var market_cap = data['quote']['USD']['market_cap'];
      this.priceChanged24H =
          double.tryParse(percent_change_24h?.toString() ?? '0');
      this.marketCap = double.tryParse(market_cap?.toString() ?? '0');
    } catch (e) {
      this.priceChanged24H = 0;
      this.marketCap = 0;
    }
  }
}
