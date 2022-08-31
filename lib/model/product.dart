import 'package:flutter/material.dart';

class Product {
  String name;
  String category;
  String description;
  String image;
  String price;
  String id;
  bool favorite;
  int quantity;

  Product({
    @required this.name,
    @required this.category,
    @required this.description,
    @required this.image,
    @required this.price,
    @required this.id,
    @required this.favorite,
     @required this.quantity,

  });

  Product.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        category = json['category'],
        description = json['description'],
        image = json['image'],
        price = json['price'],
        id = json['id'],
        favorite = json['favorite'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'description': description,
        'image': image,
        'price': price,
        'id': id,
        'favorite': favorite,
      };
}
