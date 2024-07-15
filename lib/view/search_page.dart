import 'package:flutnews/features/presentation/bloc/save/save_bloc.dart';
import 'package:flutnews/features/presentation/bloc/save/save_event.dart';
import 'package:flutnews/features/presentation/bloc/save/save_state.dart';
import 'package:flutnews/model/news/handle_model.dart';
import 'package:flutnews/model/news/news_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutnews/service/news_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Articles> history = [];
  List<Articles> result = [];
  String selectedCategory = 'ALL';
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    final newsService = NewsServiceImp();
    final newsResult = await newsService.getNews();

    if (newsResult is SuccessModel) {
      setState(() {
        history = newsResult.articles;
        result = history;
      });
    } else {
      setState(() {
        history = [];
        result = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int itemCount = 4;
    double itemWidth = screenWidth / itemCount;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 238, 241, 244),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  result = history
                      .where((article) => article.title
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search for article',
                hintStyle: TextStyle(
                  color: Color(0xff7D848D),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: Icon(Icons.search, color: Color(0xff7D848D)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7, top: 10),
            child: SizedBox(
              height: 40,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildCategoryItem('ALL', itemWidth),
                    buildCategoryItem('NEWS', itemWidth),
                    buildCategoryItem('PHOTOS', itemWidth),
                    buildCategoryItem('VIDEOS', itemWidth),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: result.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: ListTile(
                    title: Text(result[index].title),
                    subtitle: Text(result[index].description),
                    trailing: Image.network(
                      result[index].urlToImage ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image);
                      },
                    ),
                    leading: BlocBuilder<SaveBloc, SaveState>(
                      builder: (context, state) {
                        final isSaved =
                            state.savedArticles.contains(result[index]);
                        return IconButton(
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: isSaved ? Colors.blue : null,
                          ),
                          onPressed: () {
                            final saveBloc = context.read<SaveBloc>();
                            if (isSaved) {
                              saveBloc.add(RemoveArticle(result[index]));
                            } else {
                              saveBloc.add(AddArticle(result[index]));
                            }
                          },
                        );
                      },
                    ),
                  ),
                  onTap: () {},
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
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
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff001F3F) : Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        width: width,
        alignment: Alignment.center,
        child: Text(
          category,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
