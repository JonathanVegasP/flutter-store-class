import 'package:flutter_store/data/user_data.dart';
import 'package:flutter_store/inherited/bloc_provider.dart';
import 'package:flutter_store/storage/file_manager.dart';
import 'package:flutter_store/storage/files.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {
  final _user = BehaviorSubject<UserData>();

  Stream<UserData> get outUser => _user.stream;

  UserData get user => _user.value;

  set user(UserData userData) => _user.add(userData);

  Future<bool> initialize() async {
    try {
      final data = await FileManager(AppFiles.user).readData();
      user = UserData.fromJson(data);
      return true;
    }catch(e) {
      print(e);
      return false;
    }
  }

  @override
  void dispose() {
    _user.close();
  }
}