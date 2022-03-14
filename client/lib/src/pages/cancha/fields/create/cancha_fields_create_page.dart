import 'dart:io';

import 'package:client/src/models/category.dart';
import 'package:client/src/pages/cancha/fields/create/cancha_fields_create_controller.dart';
import 'package:client/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CanchaFieldsCreatePage extends StatefulWidget {
  const CanchaFieldsCreatePage({ Key key }) : super(key: key);

  @override
  State<CanchaFieldsCreatePage> createState() => _CanchaCategoriesCreatePageState();
}

class _CanchaCategoriesCreatePageState extends State<CanchaFieldsCreatePage> {

CanchaFieldsCreateController _con = new CanchaFieldsCreateController();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Cancha'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          _textFielNameCategory(),
          _textFielDescription(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical:20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _cardImage(_con.imageFile1, 1),
                _cardImage(_con.imageFile2, 2),

              ]
            ),
          ),
          _dropDownCategories(_con.categories),
          _buttonNext()
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
      
    );
  }
  Widget _textFielNameCategory() {
    return Container (
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
       controller: _con.nameController,
       maxLines: 1,
       maxLength: 180,
      decoration: InputDecoration(
        hintText: 'Nombre de la Cancha',
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        hintStyle: TextStyle(
          color: MyColors.primaryColorDark
        ),
        prefixIcon: Icon(
          Icons.sports_soccer_rounded,
          color: MyColors.primaryColor)
        ),
    ),
    );
  }

  Widget _dropDownCategories(List<Category> categories){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 33),
      child: Material(
        elevation:2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
                Row(
                  children: [
                    Icon(
                        Icons.search,
                        color: MyColors.primaryColor,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Categorias',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16
                        ),
                        ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton(
                    underline: Container(
                      alignment: Alignment.centerRight,
                      child: Icon(
                       Icons.arrow_drop_down_circle,
                       color: MyColors.primaryColor, 
                      ),
                      ),
                      elevation: 3,
                      isExpanded: true,
                      hint: Text(
                        'Seleccionar Categoria',
                        style: TextStyle(
                         color: Colors.grey,
                         fontSize: 16 
                        )
                      ),
                      items: _dropdownItems(categories),
                      value: _con.idCategory,
                      onChanged: (option){
                        setState(() {
                          print('Categoria seleccionada $option');
                          _con.idCategory = option; // ESTABLECE VALOR SELECCIONADO
                        });
                      },
                  ), 
                ),
                   
            ],),
        ),
      ),
    );
    
  }

  List<DropdownMenuItem<String>> _dropdownItems(List<Category>categories){
    List <DropdownMenuItem<String>> list = [];
    categories.forEach((category){
      list.add(DropdownMenuItem(
        child: Text(category.name),
        value: category.id,
      ));
    });

    return list;
  }


  Widget _textFielDescription() {
    return Container (
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.descriptionController,
       maxLines: 3,
       maxLength: 255,
      decoration: InputDecoration(
        hintText: 'Descripción',
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        hintStyle: TextStyle(
          color: MyColors.primaryColorDark
        ),
        prefixIcon: Icon(
          Icons.description,
          color: MyColors.primaryColor)
        ),
    ),
    );
  }

    Widget _cardImage(File imageFile , int numberFile){
      return GestureDetector(
        onTap: (){
          _con.showAlertDialog(numberFile);
        },
        child: imageFile != null 
        ? Card(
          elevation: 3.0,
          child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width * 0.26,
            child: Image.file(
            imageFile,
            fit: BoxFit.cover,
            ),
          ),
        )
        : 
        Card(
          elevation: 3.0,
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width * 0.26,
            child: Image(  
            image: AssetImage('assets/img/add-image-placeholder.png'),
            ),
          ),
        ),
      );
    }

Widget _buttonNext(){
  return Container (
    margin: EdgeInsets.only(left:30, right:30, top:30, bottom:30),
    child: ElevatedButton(
      onPressed : _con.goToAdress,
      style: ElevatedButton.styleFrom(
        primary: MyColors.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
           )

      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'Crear dirección de Cancha',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                ),
            ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left:30, top: 9),
                height:30,
                child:Icon(
                  Icons.next_plan,
                  color: Colors.white,
                  size: 30
                )
              )
            )
        ]
      )
    )
  );
}

Widget _buttonCreate() {
    return Container( 
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
    child: ElevatedButton(
      onPressed: _con.createField,
     child: Text('Crear Cancha'),
     style: ElevatedButton.styleFrom(
       primary: MyColors.primaryColor,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(30)
       ),
       padding: EdgeInsets.symmetric(vertical: 15)
     ),
     ),
     );
  }


  void refresh(){
    setState(() {
      
    });
  }


}