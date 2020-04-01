import 'package:bitcoin_ticker/Api/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen({@required this.dataCurrency});
  final dataCurrency;
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  void initState() {
    super.initState();
    setState(() {
      getUIUsd(selectedCurrency);
    });
  }

  double usd = 0;
  String selectedCurrency = 'USD';

  USDCurrency usdCurrency = USDCurrency();

  void getUIUsd(String curran) async {
    dynamic data = await usdCurrency.getUsd(curran);
    usd = data['last'];
  }

  DropdownButton<String> androidGetDown() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    for (String currentItem in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currentItem),
        value: currentItem,
      );
      dropDownItem.add(item);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItem,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getUIUsd(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> items = [];
    for (var currentItem in currenciesList) {
      var item = Text(currentItem);
      items.add(item);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {});
      },
      children: items,
    );
  }

  Widget iosORAndroid() {
    if (Platform.isIOS) {
      return iosPicker();
    } else if (Platform.isAndroid) {
      return androidGetDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCard(
            usd: usd,
            selectedCurrency: selectedCurrency,
            myCurr: 'USD',
          ),
          CryptoCard(
            usd: usd,
            selectedCurrency: selectedCurrency,
            myCurr: 'ELH',
          ),
          CryptoCard(
            usd: usd,
            selectedCurrency: selectedCurrency,
            myCurr: 'LTC',
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: iosORAndroid(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard(
      {@required this.usd,
      @required this.selectedCurrency,
      @required this.myCurr});

  final double usd;
  final String selectedCurrency;
  final String myCurr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $myCurr = $usd $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
