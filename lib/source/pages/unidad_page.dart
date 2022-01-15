import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import './../../models/nfc_models.dart';

class UnidadPage extends StatefulWidget {
  String noUnidad;
  String codigoContrato;
  String idContrato;

  UnidadPage(this.noUnidad, this.codigoContrato, this.idContrato);

  @override
  State<UnidadPage> createState() => UnidadPageState();
}

class UnidadPageState extends State<UnidadPage> {
  String _comentario = "";
  File imagen = File("...");
  ValueNotifier<dynamic> idEtiqueta = ValueNotifier(null);
  TextEditingController _nfcController = TextEditingController();
  TextEditingController _comentarioController = TextEditingController();

  @override
  void dispose() {
    _nfcController.dispose();
    _comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unidad ' + widget.noUnidad),
      ),
      body: FutureBuilder<bool>(
        future: NfcManager.instance.isAvailable(),
        builder: (context, snapshot) =>
            snapshot.data != true ? _nfcNoDisponible() : _nfcDisponible(),
      ),
    );
  }

  Widget _nfcDisponible() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue.shade200,
          Colors.red.shade200,
        ],
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.green[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "NFC Disponible.",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          _nfcReadField(),
          Container(
            //color: Colors.lime[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: imagen.path == "..."
                  ? [_botonCamara()]
                  : [_botonCamara(), _seccionFoto()],
            ),
          ),
          _comentarioTextField(),
          _botonEnviarFoto(),
        ],
      ),
    );
  }

  Widget _nfcNoDisponible() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue.shade200,
          Colors.red.shade200,
        ],
      )),
      //color: Colors.amberAccent[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.red[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "NFC No Disponible.",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          _nfcTextField(),
          Container(
            //color: Colors.lime[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: imagen.path == "..."
                  ? [_botonCamara()]
                  : [_botonCamara(), _seccionFoto()],
            ),
          ),
          _comentarioTextField(),
          _botonEnviarFoto(),
        ],
      ),
    );
  }

  Container _botonCamara() {
    return Container(
      height: MediaQuery.of(context).size.width / 2,
      width: MediaQuery.of(context).size.width / 2,
      //color: Colors.lightBlue,
      child: ElevatedButton.icon(
        onPressed: _tomarFoto,
        icon: Icon(
          Icons.camera_alt,
          size: MediaQuery.of(context).size.width / 4,
        ),
        label: Text(""),
      ),
    );
  }

  Container _seccionFoto() {
    return Container(
      height: MediaQuery.of(context).size.width / 2,
      width: MediaQuery.of(context).size.width / 2,
      //color: Colors.redAccent,
      child: (imagen.path == "")
          ? Text("Por favor, captura una fotografía.")
          : Image.file(imagen),
    );
  }

  void _leerTag() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      NfcTag2 tech = NfcTag2.fromMap(tag.data);
      List<int> identifier = tech.isodep.identifier;
      String identifier2 = identifier.join(":");
      _nfcController.text = identifier2;
      idEtiqueta.value = identifier2;
      NfcManager.instance.stopSession();
    });
  }

  void _tomarFoto() async {
    ImagePicker _picker = ImagePicker();
    XFile? _tempImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1280,
        maxHeight: 720,
        imageQuality: 70);
    if (_tempImage == null) return;
    imagen = File(_tempImage.path);
    setState(() {});
  }

  void _enviarFoto() async {
    String base64 = base64Encode(imagen.readAsBytesSync());
    String imageName = imagen.path.split("/").last;
    var data = {
      "token": "WfjQzG4cSnSENv6ukFQo7FiaAxbP19qwYdij",
      "username": "CTS3947",
      "nfc": _nfcController.text,
      "unidad": widget.noUnidad,
      "contrato": widget.codigoContrato,
      "id": widget.idContrato,
      "comentario": _comentarioController.text,
      "archivo": imageName,
      "image64": base64,
    };
    print(data);
    var url = Uri.parse(
        'http://186.10.30.50:8081/include/adaptiva/app_postserviciorealizado.php');
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*",
      },
      body: jsonEncode(data),
    );
    print(response.body);
  }

  Container _nfcTextField() {
    return Container(
      //color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: TextField(
              decoration:
                  InputDecoration(icon: Icon(Icons.nfc), labelText: "NFC Tag:"),
              controller: _nfcController,
            ),
          ),
        ],
      ),
    );
  }

  Container _nfcReadField() {
    return Container(
      //color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            child: Text('Scan'),
            onPressed: _leerTag,
            //icon: Icon(Icons.nfc),
          ),
          Flexible(
            child: TextField(
              enabled: false,
              decoration:
                  InputDecoration(icon: Icon(Icons.nfc), labelText: "NFC Tag:"),
              controller: _nfcController,
            ),
          ),
        ],
      ),
    );
  }

  Container _comentarioTextField() {
    return Container(
      //color: Colors.purpleAccent[100],
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                  icon: Icon(Icons.comment), labelText: "Comentario:"),
              controller: _comentarioController,
            ),
          ),
        ],
      ),
    );
  }

  Container _botonEnviarFoto() {
    return Container(
      //color: Colors.lightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: _enviarFoto,
            icon: Icon(
              Icons.send,
            ),
            label: Text("Enviar"),
          ),
        ],
      ),
    );
  }
}
