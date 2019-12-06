import 'package:errandiaga/model/product.dart';
import 'package:errandiaga/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  List _ingridients=[];
  Product _currentProduct;
  TextEditingController ingridients=TextEditingController();

  @override
  void initState(){
    super.initState();
    ProductNotifier productNotifier=Provider.of<ProductNotifier>(context,listen: false);
    if(productNotifier.currentProduct!=null){
      _currentProduct=productNotifier.currentProduct;
    }else{
      _currentProduct=new Product();
    }
  }
  Widget  _buildIngridients(){
    return SizedBox(width: 200,
    child: TextField(
      controller:ingridients ,
      keyboardType: TextInputType.text,
     decoration: InputDecoration(
       labelText: ' name',
     ),
    )
    );
  }

  Widget  _showImage(){
  return Center(child: Text("Image here"));
  }
 Widget _buildNameField(){
   return TextFormField(
     keyboardType: TextInputType.text,
     validator: (String value){
       if(value.isEmpty){
         return "name cannot be empty";
       }
       if(value.length<5 || value.length>15){
         return 'not ok';
       }else{
         return null;
       }
     },
     decoration: InputDecoration(
       labelText: ' name',
       icon: Icon(Icons.near_me)
     ),
     onSaved: (String value){
       _currentProduct.name=value;
     },
   );
  }
  _buildCategoryField(){
     return TextFormField(
     keyboardType: TextInputType.text,
     validator: (String value){
       if(value.isEmpty){
         return "Category cannot be empty";
       }
       if(value.length<5 || value.length>15){
         return 'not ok';
       }else{
         return null;
       }
     },
     decoration: InputDecoration(
       labelText: ' category',
       icon: Icon(Icons.near_me)
     ),
     onSaved: (String value){
       _currentProduct.category=value;
     },
   );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              _showImage(),
              SizedBox(height: 16,),
              Text("create Product"),
              SizedBox(height: 16,),
              ButtonTheme(
                child: RaisedButton(
                  onPressed: (){},
                  child: Text('Add image',style: TextStyle(color: Colors.white),),
                ),
              ),
               _buildNameField(),
               _buildCategoryField(),
               Row(
                 children: <Widget>[
                   _buildIngridients(),
                   ButtonTheme(
                     child: RaisedButton(
                       onPressed: (){},
                       child: Text('add'),
                     ),
                   )
                 ],
               )
            ],
          ),
        ),
      )
    );
  }
}