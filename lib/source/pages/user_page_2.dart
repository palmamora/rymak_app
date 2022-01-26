import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rymak/models/models.dart';
import 'package:rymak/source/pages/unidad_page.dart';

class UserPage2 extends StatefulWidget {
  Contratos contratos;

  UserPage2(this.contratos);

  @override
  _UserPage2State createState() => _UserPage2State();
}

class _UserPage2State extends State<UserPage2> {
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
        body: _body());
  }

  Widget _body() {
    return ListTileTheme(
      contentPadding: EdgeInsets.all(15),
      child: ListView(
        children: _contratosWidgets(widget.contratos),
      ),
    );
  }

  List<ExpansionTile> _contratosWidgets(Contratos contratos) {
    List<ExpansionTile> contratosWidgets = [];

    for (int i = 0; i < contratos.contratos.length; i++) {
      Contrato contrato = contratos.contratos[i];
      List<ListTile> unidadesWidgets = [];
      List<dynamic> unidades = contratos.contratos[i].unidades;
      for (int j = 0; j < unidades.length; j++) {
        dynamic unidad = unidades[j];
        unidadesWidgets.add(ListTile(
          trailing: (unidad.estado == "0")
              ? Container(
                  child: Icon(Icons.close),
                  color: Colors.red,
                )
              : Container(
                  child: Icon(Icons.check),
                  color: Colors.green,
                ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${unidad.tipo}    ',
                  style: TextStyle(fontSize: 24), textAlign: TextAlign.start),
              Text("#${unidad.noUnidad}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            ],
          ),
          onTap: () async {
            var estado = await Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return UnidadPage(unidad.noUnidad, unidad.idUnidad,
                    contrato.codigo, contrato.id, i, j);
              },
            ));
            setState(() {
              if (estado.toString() == "enviado") {
                widget.contratos.contratos[i].unidades[j].estado = "enviado";
                print(widget.contratos.contratos
                    .elementAt(i)
                    .unidades
                    .elementAt(j));
              } else {
                widget.contratos.contratos[i].unidades[j].estado = "no enviado";
                print("no enviado");
              }
            });
          },
        ));
      }

      contratosWidgets.add(ExpansionTile(
        title: Text(contrato.codigo,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
        leading: Image.asset(
          "assets/images/contrato.png",
          scale: 7,
        ),
        children: unidadesWidgets,
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
                  child: Text(contrato.comuna, style: TextStyle(fontSize: 24)))
            ]),
            Row(children: [
              Expanded(
                  child:
                      Text(contrato.telefono, style: TextStyle(fontSize: 24)))
            ]),
            Row(children: [
              Expanded(
                  child:
                      Text(contrato.contacto, style: TextStyle(fontSize: 24)))
            ])
          ],
        ),
      ));
    }

    return contratosWidgets;
  }
}
