class SrcModel
{
  String? landscape;
  String? large;
  String? large2x;
  String? medium;
  String? original;
  String? portrait;
  String? small;
  String? tiny;

  SrcModel({this.portrait,this.landscape,this.large,this.large2x,this.medium,this.original,this.small,this.tiny});

  factory SrcModel.fromJson(Map<String,dynamic>json)=>
      SrcModel(
        landscape: json['landscape'],
        large: json['large'],
        large2x: json['large2x'],
        medium: json['medium'],
        original: json['original'],
        portrait: json['portrait'],
        small: json['small'],
        tiny: json['tiny'],
      );
}


class PhotosModel
{
  String? alt;
  String? avg_color;
  int? height;
  int? id;
  bool? liked;
  String? photographer;
  int?photographer_id;
  String? photographer_url;
  SrcModel?src;
  String? url;
  int?width;

  PhotosModel({this.width,this.url,this.height,this.id,this.alt,this.avg_color,this.liked,this.photographer,
    this.photographer_id,this.photographer_url,this.src
  });

  factory PhotosModel.fromJson(Map<String,dynamic>json)=>
      PhotosModel(
        alt: json['alt'],
        avg_color: json['avg_color'],
        height: json['height'],
        id: json['id'],
        liked: json['liked'],
        photographer: json['photographer'],
        photographer_id: json['photographer_id'],
        photographer_url: json['photographer_url'],
        src: SrcModel.fromJson(json['src']),
        url: json['url'],
        width: json['width'],
      );
}


class WallPaperDataModel
{
  String? next_page;
  int? page;
  int? per_page;
  List<PhotosModel>?photos;
  int? total_results;

  WallPaperDataModel({this.next_page,this.page,this.per_page,this.photos,this.total_results});

  factory WallPaperDataModel.fromJson(Map<String,dynamic>json)
  {
    List<PhotosModel>mData = [];
    for(Map<String,dynamic>eachData in json['photos'])
      {
        mData.add(PhotosModel.fromJson(eachData));
      }
    return WallPaperDataModel(
      next_page: json['next_page'],
      page: json['page'],
      per_page: json['per_page'],
      photos: mData,
      total_results: json['total_results'],
    );
  }

}