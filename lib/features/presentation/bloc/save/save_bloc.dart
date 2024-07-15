import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutnews/features/presentation/bloc/save/save_event.dart';
import 'package:flutnews/features/presentation/bloc/save/save_state.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {
  SaveBloc() : super(const SaveState()) {
    on<AddArticle>((event, emit) {
      emit(SaveState(
        savedArticles: List.from(state.savedArticles)..add(event.article),
      ));
    });

    on<RemoveArticle>((event, emit) {
      emit(SaveState(
        savedArticles: List.from(state.savedArticles)..remove(event.article),
      ));
    });
  }
}
