import 'package:http/http.dart';
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NPR',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {
  String fetchedData;
  //final String val;
  //CoinData({this.val});

  Future getCoinData(String cryptoValue, String val) async {
    Response response = await get('$bitcoinAverageURL/$cryptoValue$val');
    if (response.statusCode == 200) {
      fetchedData = response.body;
    } else {
      print(response.statusCode);
    }
    var lastValue = jsonDecode(fetchedData)['last'];
    return lastValue.toStringAsFixed(0);
  }
}
