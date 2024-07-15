import 'package:flutter/material.dart';
import 'package:flutnews/model/news/news_model.dart';

@immutable
abstract class SaveEvent {}

class AddArticle extends SaveEvent {
  final Articles article;

  AddArticle(this.article);
}

class RemoveArticle extends SaveEvent {
  final Articles article;

  RemoveArticle(this.article);
}
