import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rymak/models/models.dart';
import 'package:rymak/source/pages/unidad_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getContratos(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return _ListaContratos(snapshot.data);
          },
        ),
      ),
    );
  }

  Future<dynamic> _getContratos() async {
    var url = Uri.parse('http://palma-mora.000webhostapp.com/index.php');
    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
    });
    return response.body;
  }
}

class _ListaContratos extends StatelessWidget {
  final dynamic data;

  _ListaContratos(this.data);

  @override
  Widget build(BuildContext context) {
    List result = convert.jsonDecode(data);
    print(result);
    Contratos contratos = Contratos.fromJson(result);
    List<ExpansionTile> contratosLista = contratos.contratos
        .map((e) => ExpansionTile(
              title: Text('Nombre Contrato: ' + e.titleContrato),
              subtitle: Text(e.emailContrato),
              children: e.unidades
                  .map((u) => ListTile(
                        title: Text('Tipo Unidad: ' + u.typeUnidad.toString()),
                        subtitle: Text('ID Unidad: ' + u.idUnidad.toString()),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UnidadPage(u.idUnidad),
                            )),
                      ))
                  .toList(),
            ))
        .toList();
    return ListView(
      children: contratosLista,
    );
  }
}
