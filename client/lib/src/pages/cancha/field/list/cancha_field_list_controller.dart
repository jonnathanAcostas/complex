import 'package:client/src/models/category.dart';
import 'package:client/src/models/field.dart';
import 'package:client/src/models/user.dart';
import 'package:client/src/provider/categories_provider.dart';
import 'package:client/src/provider/field_provider.dart';
import 'package:client/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class CanchaFieldListController{

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
  _categoriesProvider.init(context, user);
  
  
  refresh();
}

void logout(){
  _sharedPref.logout(context, user.id);
}

void goToCategoryCreate(){
  Navigator.pushNamed(context, 'cancha/categories/create');
}

void goToFieldCreate(){
  Navigator.pushNamed(context, 'cancha/fields/create');
}


void openDrawer(){
key.currentState.openDrawer();
}

void goToRoles(){
  Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
}



}




