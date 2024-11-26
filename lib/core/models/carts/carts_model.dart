import 'package:aegislabs/core/models/products/products_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'carts_model.g.dart';

@JsonSerializable()
class CartsModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "date")
  final DateTime? date;
  @JsonKey(name: "products")
  final List<Product>? products;
  @JsonKey(name: "__v")
  final int? v;

  CartsModel({
    this.id,
    this.userId,
    this.date,
    this.products,
    this.v,
  });

  factory CartsModel.fromJson(Map<String, dynamic> json) =>
      _$CartsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartsModelToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "productId")
  final int? productId;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "products")
  Products? products;

  Product({
    this.productId,
    this.quantity,
    this.products,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
