
import '../../../model/wallPaper_model.dart';

abstract class WallPaperState {}
class WallInitialState extends WallPaperState{}
class WallLoadingState extends WallPaperState{}
class WallLoadedState extends WallPaperState{
  List<PhotosModel>Photos;
  WallLoadedState({required this.Photos});
}
class WallErrorState extends WallPaperState{
  String errorMsg;
  WallErrorState({required this.errorMsg});
}
