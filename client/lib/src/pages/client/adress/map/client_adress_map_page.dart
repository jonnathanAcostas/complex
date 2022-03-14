import 'package:client/src/pages/client/adress/list/client_adress_list_controller.dart';
import 'package:client/src/pages/client/adress/map/client_adress_map_controller.dart';
import 'package:client/src/utils/my_colors.dart';
import 'package:client/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class ClientAdressMapPage extends StatefulWidget {
  const ClientAdressMapPage
({ Key key }) : super(key: key);

  @override
  State<ClientAdressMapPage> createState() => _ClientAdressMapPageState();
}

class _ClientAdressMapPageState extends State<ClientAdressMapPage> {
  
  ClientAdressMapController _con = new ClientAdressMapController();

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
        title: Text('Ubica la direccion en el mapa'),
      ),
      body: Stack(
        children: [
          _googleMaps(),
          Container(
            alignment: Alignment.center,
            child: _iconMyLocation(),
          ),
          Container(
            margin: EdgeInsets.only (top: 30),
            alignment : Alignment.topCenter,
            child:  _cardAdress(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: _buttonAccept()
          )
        ],
      )
      
    );
  }
  
Widget _buttonAccept(){
  return Container(
    height: 50,
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical:30,horizontal:70 ),
    child: ElevatedButton(
      onPressed: _con.selectRefPoint,
      child: Text(
        'Seleccionar este punto'
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

  Widget _cardAdress(){
    return Container(
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20) 
          ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(_con.adressName ?? '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold
          )
          ),
        ),
        
           
      )
    );
  }


  Widget _iconMyLocation(){
    return Image.asset(
      'assets/img/myLocation.png',
      width: 65,
      height: 65,
      );
  }


  Widget _googleMaps(){
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _con.initialPosition,
        onMapCreated: _con.onMapCreated,
        myLocationButtonEnabled: false,
        myLocationEnabled:  false,
        onCameraMove: (position){
          _con.initialPosition = position;

        },
        onCameraIdle: ()async{
          await _con.setLocationDraggableInfo();
        },

      );
  }



  void refresh() {
    setState(() {
      
    });
  }

}