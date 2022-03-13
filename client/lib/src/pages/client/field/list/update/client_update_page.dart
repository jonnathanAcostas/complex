import 'package:client/src/pages/client/field/list/update/client_update_controller.dart';
import 'package:client/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({ Key key }) : super(key: key);

  @override
  State<ClientUpdatePage> createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {

  ClientUpdateController _con = new ClientUpdateController();

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
        title: Text('Editar perfil'),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height:50),
                  _imageUser(),
                  SizedBox(height: 30),
                  _textFielName(),
                  _textFielLastName(),
                  _textFielPhone()
                ],
              ),
            )
      ),
      bottomNavigationBar:  _buttonRegister(),
    
    );
  }

  Widget _imageUser(){
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null 
        ? FileImage(_con.imageFile)
         : _con.user?.image != null ? NetworkImage(_con.user?.image)
        : AssetImage('assets/img/user_profile_2.png'),

        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );

  }

  Widget _iconBack(){
    return IconButton(
      onPressed: _con.back,
     icon: Icon(Icons.arrow_back_ios, color: Colors.white,)
     );
  }

Widget _textRegister(){
  return Text('REGISTRO',
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20
    )
  );
}

  Widget _circle(){
  return Container(
    width: 240,
    height: 230,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: MyColors.primaryColor
    ),
  );
}

  Widget _textFielName() {
    return Container (
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
      decoration: InputDecoration(
        hintText: 'Nombre',
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        hintStyle: TextStyle(
          color: MyColors.primaryColorDark
        ),
        prefixIcon: Icon(
          Icons.person,
          color: MyColors.primaryColor)
        ),
    ),
    );
  }

  Widget _textFielLastName() {
    return Container (
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.lastnameController,
      decoration: InputDecoration(
        hintText: 'Apellido',
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        hintStyle: TextStyle(
          color: MyColors.primaryColorDark
        ),
        prefixIcon: Icon(
          Icons.person_outline,
          color: MyColors.primaryColor)
        ),
    ),
    );
  }

  Widget _textFielPhone() {
    return Container (
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Teléfono',
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        hintStyle: TextStyle(
          color: MyColors.primaryColorDark
        ),
        prefixIcon: Icon(
          Icons.phone,
          color: MyColors.primaryColor)
        ),
    ),
    );
  }


  Widget _buttonRegister() {
    return Container( 
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
    child: ElevatedButton(
      onPressed: _con.isEnable ? _con.update: null,
     child: Text('ACTULIZAR PERFIL'),
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

void refresh() {
  setState(() {
    
  });
}

}
