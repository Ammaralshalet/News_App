import 'package:flutter/material.dart';
import 'package:flutnews/model/news/news_model.dart';

@immutable
class SaveState {
  final List<Articles> savedArticles;

  const SaveState({
    this.savedArticles = const [],
  });
}
