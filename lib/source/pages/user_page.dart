import 'dart:convert';

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
  final String username = "";
  final String password = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contratos'),
        leading: Icon(Icons.home),
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
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://186.10.30.50:8081/include/adaptiva/app_getvalidation.php'));
    request.body = json.encode({
      "token": "WfjQzG4cSnSENv6ukFQo7FiaAxbP19qwYdij",
      "username": "CTS3947",
      "password": "123456"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return data;
    } else {
      print(response.reasonPhrase);
    }
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
              title: Text('Contrato: ${e.codigo}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.person),
              subtitle: Column(
                children: [
                  Row(children: [Text("Comuna: ${e.comuna}")]),
                  Row(children: [
                    Expanded(child: Text("Dirección: ${e.direccion}"))
                  ])
                ],
              ),
              children: e.unidades
                  .map((u) => ListTile(
                        title: Text(
                          'Nro unidad: ${u.noUnidad}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Tipo: ${u.tipo}",
                                    textAlign: TextAlign.center,
                                  )
                                ]),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Cantidad: ${u.cantidad}",
                                    textAlign: TextAlign.center,
                                  )
                                ])
                          ],
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UnidadPage("${u.noUnidad}"),
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
