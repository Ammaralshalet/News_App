import 'package:flutnews/model/news/handle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutnews/model/news/news_model.dart';
import 'package:flutnews/service/news_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  late Future<ResultNewsModel> futureNews;
  Articles? savedArticle;
  bool seeMoreOrLess = false;

  @override
  void initState() {
    super.initState();
    futureNews = NewsServiceImp().getNews();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int itemCount = 5;
    double itemWidth = screenWidth / itemCount;
    List<Articles> articles = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grand News'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.notifications),
          ),
        ],
        leading: const Icon(Icons.menu),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7, top: 10),
            child: SizedBox(
              height: 40,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildCategoryItem('All', itemWidth),
                    buildCategoryItem('Politics', itemWidth),
                    buildCategoryItem('Sports', itemWidth),
                    buildCategoryItem('Health', itemWidth),
                    buildCategoryItem('Tech', itemWidth),
                  ],
                ),
              ),
            ),
          ),
          if (!seeMoreOrLess)
            Expanded(
              child: FutureBuilder<ResultNewsModel>(
                future: futureNews,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data is SuccessModel) {
                      articles = (snapshot.data as SuccessModel).articles;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return Card3DWidget(article: articles[index]);
                        },
                      );
                    } else if (snapshot.data is ErrorModel) {
                      return Center(
                        child: Text((snapshot.data as ErrorModel).message),
                      );
                    } else if (snapshot.data is ExceptionModel) {
                      return Center(
                        child: Text((snapshot.data as ExceptionModel).message),
                      );
                    }
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          if (!seeMoreOrLess)
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Latest News',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      seeMoreOrLess = !seeMoreOrLess;
                    });
                  },
                  child: Text(
                    seeMoreOrLess ? 'See Less' : 'See More',
                    style: const TextStyle(
                      color: Color(0xff989898),
                    ),
                  ),
                ),
              ],
            ),
          if (!seeMoreOrLess) const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<ResultNewsModel>(
              future: futureNews,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data is SuccessModel) {
                    articles = (snapshot.data as SuccessModel).articles;
                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(articles[index].title),
                          trailing: Image.network(
                            articles[index].urlToImage,
                            width: 50,
                            height: 50,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image);
                            },
                          ),
                          onTap: () {
                            setState(() {
                              savedArticle = articles[index];
                            });
                          },
                        );
                      },
                    );
                  } else if (snapshot.data is ErrorModel) {
                    return Center(
                      child: Text((snapshot.data as ErrorModel).message),
                    );
                  } else if (snapshot.data is ExceptionModel) {
                    return Center(
                      child: Text((snapshot.data as ExceptionModel).message),
                    );
                  }
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(String category, double width) {
    bool isSelected = selectedCategory == category;
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        width: width,
        alignment: Alignment.center,
        child: Text(
          category,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}

class Card3DWidget extends StatelessWidget {
  final Articles article;
  const Card3DWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final String artUrlToImage = article.urlToImage;

    if (artUrlToImage.isEmpty) {
      return const SizedBox.shrink();
    }

    final border = BorderRadius.circular(15);
    return PhysicalModel(
      color: Colors.white,
      borderRadius: border,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: border,
          child: Image.network(
            artUrlToImage,
            width: 150,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
