class Contratos {
  final List<Contrato> contratos;

  Contratos({
    required this.contratos,
  });

  factory Contratos.fromJson(List<dynamic> parsedJson) {
    List<Contrato> contratosList = [];
    contratosList = parsedJson.map((e) => Contrato.fromJson(e)).toList();
    return Contratos(
      contratos: contratosList,
    );
  }
}

class Contrato {
  final String codigo;
  final String direccion;
  final String comuna;
  final String contacto;
  final String telefono;
  final List<dynamic> unidades;

  Contrato({
    required this.codigo,
    required this.direccion,
    required this.comuna,
    required this.contacto,
    required this.telefono,
    required this.unidades,
  });

  factory Contrato.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['unidades'];
    List<dynamic> unidadesList = list.map((i) => Unidad.fromJson(i)).toList();
    return Contrato(
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
  final String? tipo;
  final String? noUnidad;
  final String? nfc;
  final int? cantidad;

  Unidad({
    required this.tipo,
    required this.noUnidad,
    required this.nfc,
    required this.cantidad,
  });

  factory Unidad.fromJson(Map<String, dynamic> parsedJson) {
    return Unidad(
      tipo: parsedJson['tipo'],
      noUnidad: parsedJson['no_unidad'],
      nfc: parsedJson['nfc'],
      cantidad: parsedJson['cantidad'],
    );
  }
}
