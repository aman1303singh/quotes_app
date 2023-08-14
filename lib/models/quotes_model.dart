import 'dart:math';

import 'package:flutter/material.dart';

List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.amber];

class QuotesModel {
  final String quotes;
  final String author;
  final Color fontColor;
  final List<dynamic> tags;

  QuotesModel({
    required this.quotes,
    required this.author,
    required this.fontColor,
    required this.tags,
  });

  factory QuotesModel.fromJson(Map<String, dynamic> map) {
    int randomValue = Random().nextInt(colors.length);
    return QuotesModel(
        quotes: map["quote"] ?? "",
        author: map["author"] ?? "",
        fontColor: colors[randomValue],
        tags: map['tags'] ?? []);
  }
}
