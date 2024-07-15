import 'package:flutnews/model/news/news_model.dart';

abstract class ResultNewsModel {}

class SuccessModel extends ResultNewsModel {
  final List<Articles> articles;

  SuccessModel({required this.articles});
}

class ErrorModel extends ResultNewsModel {
  final String message;

  ErrorModel({required this.message});
}

class ExceptionModel extends ResultNewsModel {
  final String message;

  ExceptionModel({required this.message});
}
