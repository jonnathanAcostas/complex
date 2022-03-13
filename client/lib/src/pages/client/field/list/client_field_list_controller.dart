import 'package:client/src/models/category.dart';
import 'package:client/src/models/field.dart';
import 'package:client/src/models/user.dart';
import 'package:client/src/provider/categories_provider.dart';
import 'package:client/src/provider/field_provider.dart';
import 'package:client/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientFieldListController{

BuildContext context;
SharedPref _sharedPref = new SharedPref();
GlobalKey<ScaffoldState> key= new GlobalKey<ScaffoldState>();
Function refresh;
CategoriesProvider _categoriesProvider = new CategoriesProvider();

FieldsProvider _fieldsProvider = new FieldsProvider();


User user;

List<Category> categories = [];

List<Field> fields = [];


Future init(BuildContext context, Function refresh)async{
  this.context = context;
  this.refresh = refresh;
  user = User.fromJson(await _sharedPref.read('user'));
  getCategories();
  getField('2');
  refresh();
}

void logout(){
  _sharedPref.logout(context, user.id);
}

void openDrawer(){
key.currentState.openDrawer();
}

void goToUpdatePage(){
  Navigator.pushNamed(context, 'client/update');
}

void goToRoles(){
  Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
}

void getCategories() async {
  categories = await _categoriesProvider.getAll();

  refresh();
}

Future <List<Field>> getField(String idCategory)async {
   return await _fieldsProvider.getByCategory('2');
   
}

}




