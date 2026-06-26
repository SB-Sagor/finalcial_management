import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  static StorageService get instance => Get.find();
  late final SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // Theme Key Handlers
  bool getThemeMode() => _prefs.getBool('isDarkMode') ?? false;
  Future<void> saveThemeMode(bool isDark) async => await _prefs.setBool('isDarkMode', isDark);

  // Language Key Handlers
  String getLanguage() => _prefs.getString('languageCode') ?? 'en'; // Default English
  Future<void> saveLanguage(String langCode) async => await _prefs.setString('languageCode', langCode);
}