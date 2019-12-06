
import 'dart:collection';

import 'package:errandiaga/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthNotifier with ChangeNotifier{
FirebaseUser _user;

FirebaseUser get user=>  _user;

void setUser(FirebaseUser user){
  _user=user;
  notifyListeners();
}
}
class ProductNotifier with ChangeNotifier{
  List<Product> _productList=[];

  Product _currentProduct;

  UnmodifiableListView<Product> get productList=>UnmodifiableListView(_productList);

  Product get currentProduct=> _currentProduct;

  set productList(List<Product> productList){
    _productList=productList;
    notifyListeners();
  }

  set currentProduct(Product product){
    _currentProduct=product;
    notifyListeners();
  }
}