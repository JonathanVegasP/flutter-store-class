import 'package:flutter_store/blocs/user_bloc.dart';
import 'package:flutter_store/data/product_data.dart';
import 'package:rxdart/rxdart.dart';

class SellBloc {
  final _productsSelected = BehaviorSubject<List<ProductData>>();

  Stream<List<ProductData>> get outProducts => _productsSelected.stream;
  
  var int;
  var producst;
  

  
  _addProduto(produto) {
    
  }
  
  

  set products(List<ProductData> products) {
   if(products == null) return;
   _productsSelected.add(products);
  }

  Function(List) get inProducts => _productsSelected.add;

  void dispose() {

    _productsSelected.close();
  }
}