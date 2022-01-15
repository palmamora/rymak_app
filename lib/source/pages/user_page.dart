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
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: _body(widget.data));
  }

  Widget _body(dynamic data) {
    List result = convert.jsonDecode(data);
    print(result);
    Contratos contratos = Contratos.fromJson(result);
    List<ExpansionTile> contratosWidgets = _contratosWidgets(contratos);
    return ListTileTheme(
      contentPadding: EdgeInsets.all(15),
      child: ListView(
        children: contratosWidgets,
      ),
    );
  }

  List<ExpansionTile> _contratosWidgets(Contratos contratos) {
    List<ExpansionTile> contratosWidgets = contratos.contratos
        .map((Contrato contrato) => ExpansionTile(
              backgroundColor: Colors.orange[100],
              title: Text(contrato.codigo,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
              leading: Image.asset(
                "assets/images/contrato.png",
                scale: 7,
              ),
              subtitle: Column(
                children: [
                  Row(children: [
                    Expanded(
                      child: Text(
                        contrato.direccion,
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  ]),
                  Row(children: [
                    Expanded(
                        child: Text(contrato.comuna,
                            style: TextStyle(fontSize: 24)))
                  ]),
                  Row(children: [
                    Expanded(
                        child: Text(contrato.telefono,
                            style: TextStyle(fontSize: 24)))
                  ]),
                  Row(children: [
                    Expanded(
                        child: Text(contrato.contacto,
                            style: TextStyle(fontSize: 24)))
                  ])
                ],
              ),
              children: contrato.unidades.map((dynamic unidad) {
                return ListTile(
                  trailing: (unidad.tipo != "PUNTO DE AGUA")
                      ? Image.asset(
                          "assets/images/chemical_bath.png",
                          scale: 7,
                        )
                      : Image.asset(
                          "assets/images/chemical_bath.png",
                          scale: 7,
                        ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${unidad.tipo}    ',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "#${unidad.noUnidad}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ],
                  ),
                  /*
                  subtitle: Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${unidad.tipo}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24),
                            )
                          ]),
                      /*
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Cantidad: ${unidad.cantidad}",
                              textAlign: TextAlign.center,
                            )
                          ])
                          */
                    ],
                  ),
                  */
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return UnidadPage(
                          unidad.noUnidad, contrato.codigo, contrato.id);
                    },
                  )),
                );
              }).toList(),
            ))
        .toList();
    return contratosWidgets;
  }
}
