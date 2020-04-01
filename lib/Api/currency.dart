import 'package:bitcoin_ticker/Api/networking.dart';

class USDCurrency {
  Future<dynamic> getUsd(String curr) async {
    var url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC$curr';
    NetworkingHelper networkingHelper = NetworkingHelper(url: url);
    dynamic usdCurr = await networkingHelper.getData();

    return usdCurr;
  }
}
