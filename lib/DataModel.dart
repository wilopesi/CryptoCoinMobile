// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel{

  DataModel({
    this.name,
    this.symbol,
    this.id,
    this.current_price,
    this.market_cap,
    this.imageLink,
  });

  String? name;
  String? symbol;
  String? id;
  String? current_price;
  String? market_cap;
  String? imageLink;


factory DataModel.fromJson(Map<String,dynamic> json) => DataModel(
  name: json["name"],
  symbol: json["symbol"],
  id: json["id"],
  current_price :json["current_price"],
  market_cap: json["market_cap"],
  imageLink: json["imageLink"]
);

Map<String, dynamic> toJson () => {
  "name" : name,
  "symbol" : symbol,
  "id" : id,
  "current_price" : current_price,
  "market_cap" : market_cap,
  "imageLink" :imageLink,
};
   
}