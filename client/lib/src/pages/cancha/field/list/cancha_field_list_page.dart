import 'package:client/src/models/category.dart';
import 'package:client/src/models/field.dart';
import 'package:client/src/pages/cancha/field/list/cancha_field_list_controller.dart';
import 'package:client/src/utils/my_colors.dart';
import 'package:client/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CanchaFieldListPage extends StatefulWidget {
  const CanchaFieldListPage({Key key}) : super(key: key);

  @override
  State<CanchaFieldListPage> createState() => _CanchaFieldListPageState();
}

class _CanchaFieldListPageState extends State<CanchaFieldListPage> {
  CanchaFieldListController _con = new CanchaFieldListController();

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
    return DefaultTabController(
      length: _con.categories?.length,
      child: Scaffold(
          key: _con.key,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(170),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                flexibleSpace: Column(
                  children: [
                    SizedBox(height: 40),
                    _menuDrawer(),
                    SizedBox(height: 20),
                    _textFieldSearch()
                  ],
                ),
                bottom: TabBar(
                  indicatorColor: MyColors.primaryColor,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[400],
                  isScrollable: true,
                  tabs: List<Widget>.generate(_con.categories.length, (index) {
                    return Tab(
                      child: Text(_con.categories[index].name ?? ''),
                    );
                  }),
                ),
              )),
          drawer: _drawer(),
          body: TabBarView(
            children: _con.categories.map((Category category) {
              return FutureBuilder(
                  future: _con.getFields(category.id),
                  builder: (context, AsyncSnapshot<List<Field>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return GridView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 0.7),
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (_, index) {
                              return _cardField(snapshot.data[index]);
                            });
                      } else {
                        return NoDataWidget(
                            text: 'No hay Canchas de este tipo');
                      }
                    } else {
                      return NoDataWidget(text: 'No hay Canchas de este tipo');
                    }
                  });
            }).toList(),
          )),
    );
  }

  Widget _cardField(Field field) {
    return GestureDetector(
      onTap: () {
        _con.openBottomSheet(field);
      },
      child: Container(
          height: 250,
          child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(children: [
                Column(children: [
                  Container(
                    height: 150,
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 1,
                    padding: EdgeInsets.all(5),
                    child: FadeInImage(
                      image: field.image1 != null
                          ? NetworkImage(field.image1)
                          : AssetImage('assets/img/cancha.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 33,
                      child: Text(field.name ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                          ))),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text('${field.description ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ])
              ]))),
    );
  }

  Widget _noAdress() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 30), child: NoDataWidget(text: '')),
      ],
    );
  }

  Widget _textFieldSearch() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Buscar',
            suffixIcon: Icon(Icons.search, color: Colors.grey[400]),
            hintStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey[500],
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey[300])),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey[300])),
            contentPadding: EdgeInsets.all(15)),
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
        onTap: _con.openDrawer,
        child: Container(
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: Image.asset('assets/img/menu.png', width: 20, height: 20),
        ));
  }

  Widget _drawer() {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
          decoration: BoxDecoration(color: MyColors.primaryColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''} ',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              Text(
                _con.user?.email ?? '',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                maxLines: 1,
              ),
              Text(
                _con.user?.phone ?? '',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                maxLines: 1,
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 10),
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
          )),
      ListTile(
        onTap: _con.goToCategoryCreate,
        title: Text('Crear Categoria de Cancha'),
        trailing: Icon(Icons.list_alt),
      ),
      ListTile(
        onTap: _con.goToFieldCreate,
        title: Text('Crear Nueva Cancha'),
        trailing: Icon(Icons.sports_soccer),
      ),
      ListTile(
        onTap: _con.goToUpdatePage,
        title: Text('Editar Perfil'),
        trailing: Icon(Icons.edit_outlined),
      ),
      _con.user != null
          ? _con.user.roles.length > 1
              ? ListTile(
                  onTap: _con.goToRoles,
                  title: Text('Seleccionar rol'),
                  trailing: Icon(Icons.person_outline),
                )
              : Container()
          : Container(),
      ListTile(
        onTap: _con.logout,
        title: Text('Cerrar Sesión'),
        trailing: Icon(Icons.power_settings_new),
      )
    ]));
  }

  void refresh() {
    setState(() {});
  }
}
