import 'package:client/src/models/adress.dart';
import 'package:client/src/pages/client/adress/list/client_adress_list_controller.dart';
import 'package:client/src/utils/my_colors.dart';
import 'package:client/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';



class ClientAdressListPage extends StatefulWidget {
  const ClientAdressListPage
({ Key key }) : super(key: key);

  @override
  State<ClientAdressListPage> createState() => _ClientAdressListPageState();
}

class _ClientAdressListPageState extends State<ClientAdressListPage> {
  
  ClientAdressListController _con = new ClientAdressListController();

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
        title: Text('Direcciones'),
        actions: [
          _iconAdd()
        ],
      ),
      body:Stack(
        children: [
          Positioned(
            top: 0,
            child: _textSelectAdress()

          ),
          _textSelectAdress(),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: _listAdress()),  
        ]
      ) ,
  
    );
  }
  

  Widget _noAdress(){
    return Column(
      children: [
         Container(
            margin: EdgeInsets.only(top: 30),
            child: NoDataWidget(
              text: 'Agregue nueva dirección'
              )
              ),
     
    ],
    );
  }




  Widget _listAdress(){
    return FutureBuilder(
      future: _con.getAdress(),
      builder:(context, AsyncSnapshot<List<Adress>> snapshot){
        if (snapshot.hasData){

          if(snapshot.data.length>0){

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (_, index){
                print(index);
                return _radioSelectorAdress(snapshot.data[index], index);
              },
            );
          }
          else{
            return _noAdress();
          }
        }
        else{
          return _noAdress();
        }
      }
      
    );
  
  }

  Widget _radioSelectorAdress(Adress adress, int index) {
    return Container(

      margin: EdgeInsets.symmetric(horizontal:20),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: index,
                groupValue: _con.radioValue,
                onChanged: _con.handleRadioValueChange,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adress?.adress ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  ),Text(
                    adress?.street1 ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  Text(
                    adress.street2 ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )
                  )
                ]
              ),
             
            ],
          ),
           Divider(
                color: Colors.grey
              )
        ],
      )
    );
  }

   Widget _textSelectAdress(){
     return Container(
       margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
       child: Text(
         'Selecciona ubicación de la cancha',
         style: TextStyle(
           fontSize:19,
           fontWeight: FontWeight.bold
         ),
         
         ),
         
     );
   }

  Widget _iconAdd(){
    return IconButton(
      onPressed: _con.goToNewAdress,
      icon: Icon(Icons.add, color: Colors.white)
    );
  }


  void refresh() {
    setState(() {
      
    });
  }

}