class LocalStorage {
  // static FlutterSecureStorage get securePref => sl<FlutterSecureStorage>();

  /*  static Future eraseLoginData() async {
    var loginData = (await getLoginData());
    if (loginData != null) {
      loginData.data?.accessToken = null;
      unawaited((await prefs).remove(StorageKeys.CACHED_USER_PROFILE));
      await saveLoginData(loginModel: loginData);
    }
  }

  static Future<LoginModel> getLoginData() async {
    try {
      var read = await securePref.read(key: StorageKeys.CACHED_USER);

      return LoginModel.fromJson(read);
    } catch (e) {
      return null;
    }
  }

  static Future saveLoginData({required LoginModel loginModel}) async {
    if (loginModel != null) {
      return securePref.write(
        key: StorageKeys.CACHED_USER,
        value: loginModel.toJson(),
      );
    }
  }

  static Future<String> getUserPin() async {
    return (await securePref.read(key: StorageKeys.USER_PIN)) ?? '';
  }

  static Future saveUserPin(String pin) async {
    if (pin != null) {
      return securePref.write(
        key: StorageKeys.USER_PIN,
        value: pin,
      );
    }
  }

  static Future<ProfileModel> getProfileData() async {
    try {
      return ProfileModel.fromJson(
        await securePref.read(
          key: StorageKeys.CACHED_USER_PROFILE,
        ),
      );
    } catch (e) {
      return null;
    }
  }

  static Future saveProfileData(ProfileModel data) async {
    try {
      return securePref.write(
        key: StorageKeys.CACHED_USER_PROFILE,
        value: data.toJson(),
      );
    } catch (e) {
      return null;
    }
  }
 */
  // static Future saveItem({required item, required key}) async {
  //   unawaited(securePref.write(key: key.toString(), value: item));
  // }

  // static Future eraseItem({required key}) async {
  //   unawaited(securePref.delete(key: '$key'));
  // }

  // static Future<bool> keyExists({required String key}) async {
  //   return await securePref.containsKey(key: key);
  // }

  // static void eraseAll() async {
  //   unawaited(securePref.deleteAll());
  //   return;
  // }

  // static Future<dynamic> getItemData({required key}) async {
  //   return await securePref.containsKey(key: '$key')
  //       ? securePref.read(key: '$key')
  //       : null;
  // }
}
