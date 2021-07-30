import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gotrue/gotrue.dart';

class GoTrueLocalStorage{

  static GoTrueLocalStorage shared = GoTrueLocalStorage();
  
  final _key = "session";
  late FlutterSecureStorage _storage;

  GoTrueLocalStorage(){
    _storage = const FlutterSecureStorage();
  }

  Future<void> saveSession(Session session) async{
    _storage.write(key: _key, value: session.toJson().toString());
  }

  Future<void> deleteSession() async{
    try {
      _storage.delete(key: _key);
    } catch (e) {
      // key not-found.
    }
  }

  Future<Session?> getSession() async{
    final session = await _storage.read(key: _key);
    if(session != null){
      final json = jsonDecode(session) as Map<String,dynamic>;
      return Session.fromJson(json);
    }else{
      return null;
    }
  }
}