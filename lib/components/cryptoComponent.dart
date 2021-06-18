import 'package:api_example/services/apiCalling.dart';
import 'package:api_example/models/cryptoClass.dart';
import 'package:api_example/services/localStorage.dart';
import 'package:flutter/material.dart';

class CryptoComponent extends StatefulWidget {
  final CryptoClass crypto;
  final String id;
  CryptoComponent({this.crypto, this.id, Key key}) : super(key: key) {
    assert(this.crypto != null || this.id != null);
  }

  @override
  _CryptoComponentState createState() => _CryptoComponentState();
}

class _CryptoComponentState extends State<CryptoComponent> {
  bool _expanded = false;
  CryptoClass _crypto;

  @override
  void initState() {
    super.initState();
    if (widget.crypto != null) {
      this._crypto = widget.crypto;
    } else {
      _getCrypto();
    }
  }

  void _getCrypto() async {
    this._crypto = await ApiCalling.getCryptoCurrency(widget.id);
  }

  void _toggleExpandedView() {
    setState(() {
      this._expanded = !this._expanded;
    });
  }

  void _toggleFavoriteOption() async {
    if (_isInFavorite) {
      await LocalStorage.unFavoriteCrypto(_crypto);
    } else {
      await LocalStorage.favoriteCrypto(_crypto);
    }

    setState(() {});
  }

  bool get _isInFavorite => LocalStorage.favoriteList.contains(_crypto.id);

  @override
  Widget build(BuildContext context) {
    if (this._crypto == null)
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: _toggleExpandedView,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orangeAccent,
          ),
          padding: EdgeInsets.all(15.0),
          child: Text(
            _crypto.symbol,
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _crypto.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: _toggleFavoriteOption,
              icon:
                  Icon(_isInFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.pinkAccent,
            ),
          ],
        ),
        subtitle: this._expanded
            ? Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(width: 10),
                        Text(
                          _crypto.marketCap?.toString() ?? '',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(width: 10),
                        Text(
                          ((_crypto.priceChanged24H ?? 0) > 0 ? '+ ' : '') +
                              (_crypto.priceChanged24H?.toStringAsFixed(2) ??
                                  '0') +
                              ' %',
                          style: TextStyle(
                            color: (_crypto.priceChanged24H ?? 0) < 0
                                ? Colors.red
                                : Colors.green,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
