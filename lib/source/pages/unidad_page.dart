import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UnidadPage extends StatefulWidget {
  String idUnidad;

  UnidadPage(this.idUnidad);

  @override
  State<UnidadPage> createState() => UnidadPageState(idUnidad);
}

class UnidadPageState extends State<UnidadPage> {
  String idUnidad;

  UnidadPageState(this.idUnidad);
  File image = File("...");
  ValueNotifier<dynamic> idEtiqueta = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unidad ' + idUnidad),
      ),
      body: FutureBuilder<bool>(
        future: NfcManager.instance.isAvailable(),
        builder: (context, snapshot) =>
            snapshot.data != true ? _nfcNoDisponible() : _nfcDisponible(),
      ),
    );
  }

  Center _nfcDisponible() {
    return Center(
      child: Column(
        children: [
          ValueListenableBuilder<dynamic>(
            valueListenable: idEtiqueta,
            builder: (context, value, _) => Text('${value ?? ''}'),
          ),
          ElevatedButton.icon(
            label: Text('Escanear NFC'),
            onPressed: _leerTag,
            icon: Icon(Icons.nfc_rounded),
          ),
          Container(
            child: Image.file(image),
            height: 200,
            width: 200,
          ),
          ElevatedButton.icon(
            label: Text('Tomar Fotografía'),
            onPressed: _tomarFoto,
            icon: Icon(Icons.photo_camera_rounded),
          ),
          ElevatedButton.icon(
            label: Text('Enviar'),
            onPressed: _enviarFoto,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Center _nfcNoDisponible() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error),
        Text('NFC NO DISPONIBLE.'),
      ],
    ));
  }

  void _leerTag() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      idEtiqueta.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  void _tomarFoto() async {
    ImagePicker _picker = ImagePicker();
    XFile? _tempImage = await _picker.pickImage(source: ImageSource.camera);
    if (_tempImage == null) return;
    image = File(_tempImage.path);
    setState(() {});
  }

  void _enviarFoto() async {
    String base64 = base64Encode(image.readAsBytesSync());
    String imageName = image.path.split("/").last;
    var data = {"imageName": imageName, "image64": base64};
    var url = Uri.parse('http://palma-mora.000webhostapp.com/index.php');
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*",
      },
      body: jsonEncode(data),
    );
    print(response.statusCode);
  }
}
