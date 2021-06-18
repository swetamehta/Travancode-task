import 'package:api_example/models/cryptoClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences _preferences;

  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static List<String> get favoriteList =>
      _preferences?.getStringList('favoriteList') ?? [];

  static Future<void> favoriteCrypto(CryptoClass crypto) async {
    if (!favoriteList.contains(crypto.id)) {
      List<String> favorites = favoriteList;
      favorites.add(crypto.id);
      await _preferences.setStringList('favoriteList', favorites);
      await _preferences.reload();
    }
  }

  static Future<void> unFavoriteCrypto(CryptoClass crypto) async {
    if (favoriteList.contains(crypto.id)) {
      List<String> favorites = favoriteList;
      favorites.remove(crypto.id);
      await _preferences.setStringList('favoriteList', favorites);
      await _preferences.reload();
    }
  }
}
