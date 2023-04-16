import 'dart:convert';

import 'package:clean_dart/app/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  ResultSearchModel(
      {required super.img, required super.title, required super.content});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'img': img,
      'title': title,
      'content': content,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      img: map['avatar_url'],
      title: map['login'],
      content: map['node_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
