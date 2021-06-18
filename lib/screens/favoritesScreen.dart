import 'package:api_example/components/cryptoComponent.dart';
import 'package:api_example/services/localStorage.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.3),
        appBar: AppBar(
          title: Text('Favorite Cryptos'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: ListView.builder(
            itemCount: LocalStorage.favoriteList.length,
            itemBuilder: (context, i) => CryptoComponent(
              id: LocalStorage.favoriteList[i],
            ),
          ),
        ),
      ),
    );
  }
}
