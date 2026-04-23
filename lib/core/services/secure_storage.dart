import "package:flutter_secure_storage/flutter_secure_storage.dart";

//Untuk simpan JWT dari backend di storage internal hp user
class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      keyCipherAlgorithm:
          KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding, //mengunci tempat token dikunci
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding, //mengunci token
    ),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock), //mengatur akses data setelah HP pertama kali dibuka, 
                                                                             //jadi kalau HP dimatikan lalu dinyalakan lagi, data tetap bisa diakses tanpa harus login ulang, 
                                                                             //tapi kalau HP dimatikan terus dinyalakan lagi, data baru bisa diakses setelah user login ulang, 
                                                                             //jadi ini untuk keamanan data kalau HP hilang atau dicuri
  );

  static const _keyToken = 'auth_token'; //Ini JWT, diinisilisasi sebagai _keyToken

  static Future<void> saveToken(String token) async =>
      _storage.write(key: _keyToken, value: token); //Ini untuk simpan token ketika login berhasil

  static Future<String?> getToken() async => _storage.read(key: _keyToken); //Ini untuk ambil token ketika request API

  static Future<void> clearAll() async => _storage.deleteAll(); //Hapus semua yang tersimpan di HP termasuk JWT-nya ketika logout
}
