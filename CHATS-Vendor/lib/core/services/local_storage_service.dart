import 'package:CHATS_Vendor/core/provider_model/base_provider_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends BaseProviderModel {
  SharedPref() {
    setupShared();
    getIsFirstTime();
  }
  Future<SharedPreferences> pref;
  static const fullname = 'name';
  static const first_time = 'first_time';

  setupShared() {
    pref = SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<bool> myFirst;

  getIsFirstTime() {
    myFirst = pref.then((value) {
      return value.getBool(first_time) ?? true;
    });
  }

  setIsFirstTime(bool content) async {
    final SharedPreferences preferences = await pref;
    myFirst = preferences.setBool(first_time, content).then((value) {
      return content;
    });
    notifyListeners();
  }
}
