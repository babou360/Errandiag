import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  String id;
  String name;
  String category;
  String image;
  List ingridients=[];
  Timestamp createdAt;
  Timestamp updatedAt;

  Product();

  Product.fromMap(Map<String,dynamic> data){
    id=data['id'];
    id=data['name'];
    id=data['category'];
    id=data['image'];
    id=data['ingridients'];
    id=data['createdAt'];
    id=data['updatedAt'];
  }
  Map<String,dynamic>toMap(){
    return {
      'id':id,
      'name':name,
      'category':category,
      'image':image,
      'ingridients':ingridients,
      'createdAt':createdAt,
      'updatedAt':updatedAt
    };
  }

}