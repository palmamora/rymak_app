class Contratos {
  List<dynamic> contratos;

  Contratos({
    required this.contratos,
  });

  factory Contratos.fromJson(List<dynamic> parsedJson) {
    List<dynamic> contratosList = [];
    contratosList = parsedJson.map((e) => Contrato.fromJson(e)).toList();
    return Contratos(
      contratos: contratosList,
    );
  }
}

class Contrato {
  String id;
  String codigo;
  String direccion;
  String comuna;
  String contacto;
  String telefono;
  List<dynamic> unidades;

  Contrato({
    required this.id,
    required this.codigo,
    required this.direccion,
    required this.comuna,
    required this.contacto,
    required this.telefono,
    required this.unidades,
  });

  factory Contrato.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['unidades'];
    List<dynamic> unidadesList = [];
    unidadesList = list.map((i) => Unidad.fromJson(i)).toList();
    return Contrato(
      id: parsedJson['id'],
      codigo: parsedJson['codigo'],
      direccion: parsedJson['direccion'],
      comuna: parsedJson['comuna'],
      contacto: parsedJson['contacto'],
      telefono: parsedJson['telefono'],
      unidades: unidadesList,
    );
  }
}

class Unidad {
  String tipo;
  String noUnidad;
  String nfc;
  int cantidad;
  String estado;
  String idUnidad;

  Unidad({
    required this.tipo,
    required this.noUnidad,
    required this.nfc,
    required this.cantidad,
    required this.estado,
    required this.idUnidad,
  });

  factory Unidad.fromJson(Map<String, dynamic> parsedJson) {
    return Unidad(
        tipo: parsedJson['tipo'],
        noUnidad: parsedJson['no_unidad'],
        nfc: parsedJson['nfc'].toString(),
        cantidad: parsedJson['cantidad'],
        estado: parsedJson['estado'].toString(),
        idUnidad: parsedJson['unidadid']);
  }
}
