import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/data/bloc/searchBloc/search_event.dart';
import 'package:wallpaper_app/data/bloc/searchBloc/search_state.dart';

import '../../../model/wallPaper_model.dart';
import '../../../repository/wallpaper_repository.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>
{
  WallPaperRepository wallPaperRepository;
  SearchBloc({required this.wallPaperRepository}):super(SearchInitialState()){
    on<WallSearchEvent>((event,emit)async{
      emit(SearchLoadingState());
          try{
            var data  =await wallPaperRepository.getSearchWallPaper(mquery: event.query,mColor: event.color,mPage: event.page);
            //WallPaperDataModel wallPaperModel =  WallPaperDataModel.fromJson(data);
             var wallPaperModel =  WallPaperDataModel.fromJson(data);
            emit(SearchLoadedState(wallPaperDataModel: wallPaperModel));
          }catch(e){
            emit(SearchErrorState(ErrorMsg: e.toString()));

          }
    });
  }
}