import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/screens/wallpaper_page.dart';

import 'data/bloc/GetBloc/wallpaper_bloc.dart';
import 'data/remote/api_helper.dart';

void main()
{
  runApp(BlocProvider(create: (context)=>WallPaperBloc(wallPaperRepository: WallPaperRepository(apiHelper: ApiHelper())),child: Wallpaper(),));
}
class Wallpaper extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:WallpaperPage(),
    );
  }

}
