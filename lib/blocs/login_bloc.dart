import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_store/blocs/user_bloc.dart';
import 'package:flutter_store/data/user_data.dart';
import 'package:flutter_store/database/db.dart';
import 'package:flutter_store/inherited/bloc_provider.dart';
import 'package:flutter_store/storage/file_manager.dart';
import 'package:flutter_store/storage/files.dart';
import 'package:flutter_store/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState {LOADING, DONE, INVALID_EMAIL,INVALID_PASS,NETWORK_ERROR,UNKNOWN_ERROR}

class LoginBloc extends BlocBase with LoginValidators   {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _state = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _email.stream.transform(emailValidator);

  Stream<String> get outPassword  => _password.stream.transform(passowrdValidator);

  Function(String) get inEmail => _email.add;

  Function(String) get inPassword => _password.add;

  Stream<bool> get validator => CombineLatestStream([outEmail,outPassword], (_) => true);

  Stream<LoginState> get outState => _state.stream;

  void validateFields() {
    if(_email.value == null) _email.add("");
    if(_password.value == null) _password.add("");
  }

  Future<LoginState> signIn(UserBloc bloc) async {
    try {
      _state.add(LoginState.LOADING);
      final map = await DB().getDataByJson("users", {
        "email": _email.value.trim().toLowerCase(),
      });
      if(map["users"] == null) {
        _state.add(LoginState.INVALID_EMAIL);
        return _state.value;
      }
      final users = map["users"] as List;
      final pass = md5.convert(utf8.encode(_password.value)).toString();
      if(users[0]["password"] != pass) {
        _state.add(LoginState.INVALID_PASS);
        return _state.value;
      }
      final user = UserData.fromJson(users[0]);
      FileManager(AppFiles.user).saveData(user.toJson());
      bloc.user = user;
      _state.add(LoginState.DONE);
    } on SocketException {
     _state.add(LoginState.NETWORK_ERROR);
    }
    catch(e) {
      print(e);
      _state.add(LoginState.UNKNOWN_ERROR);
    }
    return _state.value;
  }

  @override
  void dispose() {
    _email.close();
    _password.close();
    _state.close();
  }
}