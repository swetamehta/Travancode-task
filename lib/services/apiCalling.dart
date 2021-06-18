import 'dart:convert';

import 'package:api_example/models/cryptoClass.dart';
import 'package:http/http.dart' as http;

class ApiCalling {
  static Future<List<CryptoClass>> getCryptoCurrencies({int start}) async {
    Map<String, String> headers = {
      'X-CMC_PRO_API_KEY': 'c6b4620f-ceb7-480b-962e-effc04ac7c61',
      'Accept': 'application/json'
    };

    http.Response resp = await http.get(
      Uri.parse(
          'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=${start ?? 1}&limit=5&convert=USD'),
      headers: headers,
    );
    List<dynamic> data = (jsonDecode(resp.body))['data'];

    List<CryptoClass> cryptos = new List<CryptoClass>.generate(
      data.length,
      (i) => CryptoClass.fromJson(data[i]),
    );

    return cryptos;
  }

  static Future<CryptoClass> getCryptoCurrency(String id) async {
    Map<String, String> headers = {
      'X-CMC_PRO_API_KEY': 'c6b4620f-ceb7-480b-962e-effc04ac7c61',
      'Accept': 'application/json'
    };

    http.Response resp = await http.get(
      Uri.parse(
          'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?id=$id'),
      headers: headers,
    );
    dynamic data = (jsonDecode(resp.body))['data'];

    CryptoClass crypto = CryptoClass.fromJson(data[id]);

    return crypto;
  }
}
