import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper/wallpaper.dart';
import '../model/wallPaper_model.dart';
import '../utills/utills_helper.dart';

class DetailPage extends StatelessWidget
{
  SrcModel srcModel;
  double? width, height;
  DetailPage({required this.srcModel});
  @override
  Widget build(BuildContext context)
  {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
   return Scaffold(
     body: Stack(
     children: [
     Container(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         child: Image.network(srcModel.portrait! ,fit: BoxFit.cover,)
     ),
     Align(
       alignment: Alignment.bottomCenter,
       child: Padding(
         padding: const EdgeInsets.symmetric(vertical: 16.0),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
            mColumn(mIcon: Icons.info, title: "Info", onTap: (){}),
            SizedBox(width: 21,),
            mColumn(mIcon: Icons.download, title: "Save", onTap: (){
              saveWallPaper(context);},),
             SizedBox(width: 21,),
            mColumn(mIcon: Icons.brush, title: "Apply", onTap: () {

              showModalBottomSheet(context: context, builder: (context){
                return Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white,),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(onPressed: (){
                      applyWallPaper(context,check: 1);
                      Navigator.pop(context);
                    }, child:  Text("Set WallPaper On Home Screen",style: mTextStyle16(),),),
                    TextButton(onPressed: (){
                      applyWallPaper(context,check: 2);
                      Navigator.pop(context);
                    }, child:  Text("Set WallPaper On Lock Screen",style: mTextStyle16(),),),
                    TextButton(onPressed: (){
                      applyWallPaper(context,check: 3);
                      Navigator.pop(context);
                    }, child:  Text("Set WallPaper On Both Screen",style: mTextStyle16(),),),
                  ],
                  ),
                );
              });
             // applyWallPaper(context);
            },bgColor: Colors.blueAccent),
             ],
         ),
       ),
     )

       ]));
  }


  void saveWallPaper(BuildContext context){
    GallerySaver.saveImage(srcModel.portrait!).then((value)=>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("WallPaper Save onto gallery !!")))
    );
  }
  void applyWallPaper(BuildContext context,{required int check})
  {
    Wallpaper.imageDownloadProgress(srcModel.portrait!).listen((event){
     print(event);
    },onDone: (){
      /// WallPaper Set on HomeScreen
        if(check==1){
      Wallpaper.homeScreen(
          height: height!,
          width: width!,
          options: RequestSizeOptions.resizeFit
      ).then((value) {
        print(value);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("WallPaper Set On Home Screen !!")));
      });
    }

        if(check==2){
          Wallpaper.lockScreen(
              height: height!,
              width: width!,
              options: RequestSizeOptions.resizeFit
          ).then((value) {
            print(value);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("WallPaper Set On Home Screen !!")));
          });
        }


        if(check==3){
          Wallpaper.bothScreen(
              height: height!,
              width: width!,
              options: RequestSizeOptions.resizeFit
          ).then((value) {
            print(value);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("WallPaper Set On Home Screen !!")));
          });
        }


    },onError: (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Download Error:$e, Error while settings the WallPaper !!")));
    }

    );
  }
}

