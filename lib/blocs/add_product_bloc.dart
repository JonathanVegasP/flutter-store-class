import 'package:flutter_store/database/db.dart';

class AddProductBloc
{

  Future<bool> saveProduct() async {
    try {
      final map = await DB().createTable("products", {
      });
      return true;
    }catch(e) {
      print(e);
      return false;
    }
  }

  void dispose() {
  }
}