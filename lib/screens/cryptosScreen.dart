import 'package:api_example/services/apiCalling.dart';
import 'package:api_example/models/cryptoClass.dart';
import 'package:api_example/components/cryptoComponent.dart';
import 'package:flutter/material.dart';

class CryptosScreen extends StatefulWidget {
  @override
  _CryptosScreenState createState() => _CryptosScreenState();
}

class _CryptosScreenState extends State<CryptosScreen> {
  List<CryptoClass> _cryptos = [];

  void _getCryptos() async {
    this._cryptos.addAll(
          await ApiCalling.getCryptoCurrencies(
              start: (this._cryptos?.length ?? 0) + 1),
        );
    print(this._cryptos);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.3),
        appBar: AppBar(
          title: Text('Cryptocurrencies'),
        ),
        body: (this._cryptos?.length ?? 0) > 0
            ? ListView.builder(
                itemCount: this._cryptos.length +
                    ((this._cryptos?.length ?? 0) > 0 ? 1 : 0),
                itemBuilder: (context, i) {
                  if (i == this._cryptos.length) {
                    return GestureDetector(
                      onTap: _getCryptos,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 120,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orangeAccent,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 5),
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Text(
                          "Load More",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return CryptoComponent(
                      crypto: this._cryptos[i],
                    );
                  }
                })
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
