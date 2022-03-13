import 'dart:convert';
import 'dart:io';

import 'package:client/src/models/category.dart';
import 'package:client/src/models/field.dart';
import 'package:client/src/models/response_api.dart';
import 'package:client/src/models/user.dart';
import 'package:client/src/provider/categories_provider.dart';
import 'package:client/src/provider/field_provider.dart';
import 'package:client/src/utils/my_snackbar.dart';
import 'package:client/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class CanchaFieldsCreateController{

  BuildContext context;
  Function refresh;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

CategoriesProvider _categoriesProvider = new CategoriesProvider();
FieldsProvider _fieldsProvider = new FieldsProvider();


User user;
SharedPref sharedPref = new SharedPref();

  List<Category> categories = [];
  String idCategory; // Almacena id Cartegoria 

//IMAGENES
PickedFile pickedFile;
File imageFile1;
File imageFile2;

ProgressDialog _progressDialog;



  Future init(BuildContext context, Function refresh) async {

    this.context = context;
    this.refresh = refresh;
    _progressDialog = new ProgressDialog (context: context);
    user = User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _fieldsProvider.init(context, user);
    getCategories();
  }

  void getCategories() async{

    categories =await _categoriesProvider.getAll(); 
    refresh();

  }

void createField() async {
  String name = nameController.text;
  String description = descriptionController.text;

  if (name.isEmpty || description.isEmpty ){
    MySnackbar.show(context, 'Debe ingresar todos los campos');
    return;
  }

  if (imageFile1 == null || imageFile2 == null){
    MySnackbar.show(context, 'Selecciona las imagenes');
    return;
  }

  if (idCategory == null){
    MySnackbar.show(context, 'Selecciona la categoria de la cancha');
    return;
  }

  Field field = new Field(
    name: name,
     description: description,
     idCategory: int.parse(idCategory),
     );

  List<File> images = [];
  images.add(imageFile1);
  images.add(imageFile2);

  _progressDialog.show(max: 100, msg: 'Espere un momento');

  Stream stream = await _fieldsProvider.create(field, images);
  stream.listen((res) { 
    _progressDialog.close();

    ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
    MySnackbar.show(context, responseApi.message);

    if (responseApi.success){
      resetValues();
    }

  });

  print('Formulario Cancha:${field.toJson()}');
}


void resetValues(){
  nameController.text = '';
  descriptionController.text = '';
  imageFile1 = null;
  imageFile2 = null;
  idCategory = null;
  refresh();
}


 Future selectImage(ImageSource imageSource, int numberFile )async{
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile != null){

      if(numberFile == 1){

        imageFile1 = File(pickedFile.path);
      }
      else if(numberFile == 2){
        imageFile2 = File(pickedFile.path);
      }
      
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(int numberFile){
    Widget galleryButton = ElevatedButton(
      onPressed: (){
        selectImage(ImageSource.gallery, numberFile);
      }, 
      child: Text('GALERIA')
      );
 Widget cameraButtom = ElevatedButton(
      onPressed: (){
        selectImage(ImageSource.camera, numberFile);
      }, 
      child: Text('CAMARA')
      );

      AlertDialog alertDialog = AlertDialog(
        title: Text('Selecciona tu imagen'),
        actions: [
          galleryButton,
          cameraButtom
        ],
        );

        showDialog(
          context: context,
          builder: (BuildContext context){
            return alertDialog;
          }
        );




  }



}