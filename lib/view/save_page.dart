import 'package:flutnews/features/presentation/bloc/save/save_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutnews/features/presentation/bloc/save/save_bloc.dart';
import 'package:flutnews/features/presentation/bloc/save/save_state.dart';

class SavePage extends StatelessWidget {
  const SavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
        centerTitle: true,
      ),
      body: BlocBuilder<SaveBloc, SaveState>(
        builder: (context, state) {
          if (state.savedArticles.isEmpty) {
            return const Center(
              child: Text('No articles saved'),
            );
          }
          return ListView.builder(
            itemCount: state.savedArticles.length,
            itemBuilder: (context, index) {
              final article = state.savedArticles[index];
              return ListTile(
                title: Text(article.title),
                subtitle: Text(article.description ?? ''),
                trailing: article.urlToImage != null
                    ? Image.network(
                        article.urlToImage!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image);
                        },
                      )
                    : const Icon(Icons.image_not_supported),
                leading: IconButton(
                  icon: const Icon(Icons.bookmark_remove),
                  onPressed: () {
                    context.read<SaveBloc>().add(RemoveArticle(article));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
