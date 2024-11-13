abstract class SearchEvent{}
class WallSearchEvent extends SearchEvent{
  String query;
  String color;
  int page;
  WallSearchEvent({required this.query,this.color='',this.page=1});
}