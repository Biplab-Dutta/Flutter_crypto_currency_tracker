import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String bitCoinValue = '?';
  String bitCoinValue2 = '?';
  String bitCoinValue3 = '?';
  @override
  void initState() {
    super.initState();
    getData();
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  void getData() async {
    CoinData object = CoinData();
    var data = await object.getCoinData('BTC', selectedCurrency);
    var data2 = await object.getCoinData('ETH', selectedCurrency);
    var data3 = await object.getCoinData('LTC', selectedCurrency);

    setState(
      () {
        bitCoinValue = data;
        bitCoinValue2 = data2;
        bitCoinValue3 = data3;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CardStyle(
              cryptoCurrency: cryptoList[0],
              coinValue: bitCoinValue,
              optedCurrency: selectedCurrency),
          CardStyle(
              cryptoCurrency: cryptoList[1],
              coinValue: bitCoinValue2,
              optedCurrency: selectedCurrency),
          CardStyle(
              cryptoCurrency: cryptoList[2],
              coinValue: bitCoinValue3,
              optedCurrency: selectedCurrency),
          //Padding(
          // padding: EdgeInsets.only(top: 380.0),
          Spacer(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
          //),
        ],
      ),
    );
  }
}
