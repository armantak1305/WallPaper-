
import '../../../model/wallPaper_model.dart';

abstract class SearchState {}
class SearchInitialState extends SearchState{}
class SearchLoadingState extends SearchState{}
class SearchLoadedState extends SearchState{
  //List<PhotosModel> photos;
   WallPaperDataModel wallPaperDataModel;
  SearchLoadedState({required this.wallPaperDataModel});
 // SearchLoadedState({required this.photos});
}
class SearchErrorState extends SearchState{
  String ErrorMsg;
  SearchErrorState({required this.ErrorMsg});
}