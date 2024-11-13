
import '../data/remote/api_helper.dart';
import '../data/remote/urls.dart';

class WallPaperRepository
{
  ApiHelper apiHelper;
  WallPaperRepository({required this.apiHelper});
/// Trending wallpaper
  Future<dynamic> getTrendingWallPaper()
  async{
    try {
     return await apiHelper.getApi(url: Urls.Trending_Wall_Url,);
    }catch(e){
      throw(e);
      //rethrow;
    }
  }

/// Search Wallpaper
  Future<dynamic>getSearchWallPaper({required String mquery, String mColor='',int mPage=1})
  async{
    try{
      return await apiHelper.getApi(url: "${Urls.Search_Url}?query=$mquery${mColor==""?"":"&color=$mColor"}&page=$mPage");
    }catch(e){
      throw(e);
    }

  }
}