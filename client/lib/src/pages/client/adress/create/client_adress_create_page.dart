import 'package:client/src/pages/client/adress/create/client_adress_create_controller.dart';
import 'package:client/src/pages/client/adress/list/client_adress_list_controller.dart';
import 'package:client/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';



class ClientAdressCreatePage extends StatefulWidget {
  const ClientAdressCreatePage
({ Key key }) : super(key: key);

  @override
  State<ClientAdressCreatePage> createState() => _ClientAdressCreatePageState();
}

class _ClientAdressCreatePageState extends State<ClientAdressCreatePage> {
  
  ClientAdressCreateController _con = new ClientAdressCreateController();

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

        _con.init(context, refresh);
    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva dirección')
      ),
      bottomNavigationBar: _buttonAccept(),
      body: Column(
        children: [
          _textCompleteData(),
          _textFieldAdress(),
          _textFieldStreet1(),
          _textFieldStreet2(),
          _textReference()
        ]
      )
      
    );
  }


  Widget _textFieldAdress(){
    return Container(
      margin:EdgeInsets.symmetric(horizontal:50, vertical: 10),
      child: TextField(
        controller: _con.adressController,
        decoration: InputDecoration(
          labelText: 'Dirección',
          suffixIcon: Icon(
            Icons.location_on,
            color: MyColors.primaryColor)
        )
      )
    );

  }

  
  Widget _textFieldStreet1(){
    return Container(
      margin:EdgeInsets.symmetric(horizontal:50, vertical: 10),
      child: TextField(
        controller: _con.street1Controller,
        decoration: InputDecoration(
          labelText: 'Calle Principal',
          suffixIcon: Icon(
            Icons.location_city,
            color: MyColors.primaryColor)
        )
      )
    );
  }

  Widget _textFieldStreet2(){
    return Container(
      margin:EdgeInsets.symmetric(horizontal:50, vertical: 10),
      child: TextField(
        controller: _con.street2Controller,
        decoration: InputDecoration(
          labelText: 'Calle Secundaria',
          suffixIcon: Icon(
            Icons.location_city,
            color: MyColors.primaryColor)
        )
      )
    );

  }
  Widget _textReference(){
    return Container(
      margin:EdgeInsets.symmetric(horizontal:50, vertical: 10),
      child: TextField(
        controller: _con.refPointController,
        onTap: _con.openMap,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
          labelText: 'Referencia',
          suffixIcon: Icon(
            Icons.map_outlined,
            color: MyColors.primaryColor)
        )
      )
    );

  }


  Widget _buttonAccept(){
  return Container(
    height: 50,
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical:50,horizontal:50 ),
    child: ElevatedButton(
      onPressed:_con.createAdress ,
      child: Text(
        'Agregar Dirección'
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          primary: MyColors.primaryColor
        ),
    ),
  );
}



Widget _textCompleteData(){
     return Container(
       margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
       child: Text(
         'Complete los siguientes datos',
         style: TextStyle(
           fontSize:19,
           fontWeight: FontWeight.bold
         ),
         
         ),
         
     );
   }

  void refresh() {
    setState(() {
      
    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {

  @override

  bool get hasFocus => false;
}