import 'package:client/src/pages/client/field/list/client_field_list_controller.dart';
import 'package:client/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientFieldListPage extends StatefulWidget {
  const ClientFieldListPage({Key key}) : super(key: key);

  @override
  State<ClientFieldListPage> createState() => _ClientFieldListPageState();
}

class _ClientFieldListPageState extends State<ClientFieldListPage> {
  ClientFieldListController _con = new ClientFieldListController();

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
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      body: Center(
        child: ElevatedButton(
            onPressed: _con.logout, child: Text('Cerrar Sesión')),
      ),
    );
  }

  Widget _menuDrawer(){
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin:  EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png', width: 20, height: 20),
      )
    );
  }


  Widget _drawer() {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
      DrawerHeader(
        decoration:  BoxDecoration(
          color: MyColors.primaryColor
        ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [
          Text(
            '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''} ',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                  ),
                  maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[200],
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[200],
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                  ),
               Container(
                 height: 60,
                 margin:  EdgeInsets.only(top: 10),
                 child: FadeInImage(
                   image: _con.user?.image != null
                    ? NetworkImage(_con.user?.image) 
                    : AssetImage('assets/img/no-image.png'),
                   fit: BoxFit.contain,
                   fadeInDuration: Duration(milliseconds: 50),
                   placeholder: AssetImage('assets/img/no-image.png'),
                 ),
               ) 
              

        ],
      )
      ),

      ListTile(
        onTap: _con.goToUpdatePage,
        title: Text('Editar Perfil'),
        trailing:  Icon(Icons.edit_outlined),

      ),
  ListTile(
        title: Text('Mis canchas'),
        trailing:  Icon(Icons.sports_soccer),
        
      ),
      _con.user != null ? 
      _con.user.roles.length >1 ?
      ListTile(
        onTap: _con.goToRoles,
        title: Text('Seleccionar rol'),
        trailing:  Icon(Icons.person_outline),
        
      ): Container(): Container(),

      ListTile(
        onTap: _con.logout,
        title: Text('Cerrar Sesión'),
        trailing:  Icon(Icons.power_settings_new),
        
      )
    ]));
  }

  void refresh() {
    setState(() {
      
    });
  }
}
