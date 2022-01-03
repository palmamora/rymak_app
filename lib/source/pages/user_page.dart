import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rymak/models/models.dart';
import 'package:rymak/source/pages/unidad_page.dart';

class UserPage extends StatefulWidget {
  dynamic data;

  UserPage(this.data);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contratos'),
          leading: Icon(Icons.home),
          actions: [
            IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: _ListaContratos(widget.data));
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
