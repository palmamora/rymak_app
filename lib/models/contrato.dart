// To parse this JSON data, do
//
//     final contrato = contratoFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

class Contrato {
    Contrato({
        required this.idContrato,
        required this.titleContrato,
        required this.emailContrato,
        required this.unidades,
    });

    String idContrato;
    String titleContrato;
    String emailContrato;
    List<Unidad> unidades;

    factory Contrato.fromJson(String str) => Contrato.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Contrato.fromMap(Map<String, dynamic> json) => Contrato(
        idContrato: json["idContrato"],
        titleContrato: json["titleContrato"],
        emailContrato: json["emailContrato"],
        unidades: List<Unidad>.from(json["unidades"].map((x) => Unidad.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "idContrato": idContrato,
        "titleContrato": titleContrato,
        "emailContrato": emailContrato,
        "unidades": List<Unidad>.from(unidades.map((x) => x.toMap())),
    };
}

