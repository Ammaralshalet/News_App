import 'package:flutnews/core/constants/constants.dart';
import 'package:flutnews/model/news/handle_model.dart';
import 'package:flutnews/model/news/news_model.dart';
import 'package:flutnews/service/core_service.dart';

abstract class Service extends CoreSerivce {
  Future<ResultNewsModel> getNews();
}

class NewsServiceImp extends Service {
  @override
  Future<ResultNewsModel> getNews() async {
    try {
      final response = await dio.get(baseurlNews);
      if (response.statusCode == 200) {
        List<Articles> articles = List.generate(
          response.data['articles'].length,
          (index) => Articles.fromMap(response.data['articles'][index]),
        );
        return SuccessModel(articles: articles);
      } else {
        return ErrorModel(message: 'Failed to load articles');
      }
    } catch (e) {
      return ExceptionModel(message: e.toString());
    }
  }
}
