import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_app/screens/search_wall_page.dart';
import '../app_containst.dart';
import '../data/bloc/GetBloc/wallpaper_bloc.dart';
import '../data/bloc/GetBloc/wallpaper_event.dart';
import '../data/bloc/GetBloc/wallpaper_state.dart';
import '../data/bloc/searchBloc/search_bloc.dart';
import '../data/remote/api_helper.dart';
import '../repository/wallpaper_repository.dart';
import '../utills/utills_helper.dart';
import 'detail_page.dart';

class WallpaperPage extends StatefulWidget
{  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage>
{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WallPaperBloc>().add(GetWallPaperEvent());
  }
   TextEditingController wallController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.primaryLightColor,
      body:BlocBuilder<WallPaperBloc,WallPaperState>(builder: (_,state){
        if(state is WallLoadingState){
          return Center(child: CircularProgressIndicator(),);
        }else if(state is WallErrorState){
          return Center(child: Lottie.asset("assets/lottie/network.json"),);
        }else if(state is WallLoadedState){
          var mdata = state.Photos;
          return ListView(
            shrinkWrap: true,
            children: [
              Container(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: TextField(controller: wallController,
                  decoration: InputDecoration(hintText: "Find Wallpaper....",
                    fillColor: AppColors.secondaryLightColor,
                    filled: true,
                    suffixIcon:IconButton(onPressed: (){
                        if(wallController.text.isNotEmpty){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>
                              SearchBloc(wallPaperRepository: WallPaperRepository(apiHelper: ApiHelper())),child: SearchWallPage(query: wallController.text))));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: Please fill blank field")));
                        }
                    }, icon: Icon(Icons.search,size: 30,color: Colors.grey.shade400,)),
                    hintStyle: mTextStyle12(mColor: Colors.grey.shade400,),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(width: 0,color: Colors.transparent),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(width: 0,color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(width: 0,color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 11,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                child: Text("Best of the month",style:mTextStyle16(mFontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 7,),
              Container(height: 250,width: double.infinity,
                child: ListView.builder(
                    itemCount: state.Photos.length,
                    scrollDirection:Axis.horizontal,
                    itemBuilder: (_,index)
                    {
                      var eachPhoto = state.Photos[index];
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(srcModel: eachPhoto.src!)));
                        },
                        child: Container(height:200,width:150,
                            margin: EdgeInsets.only(left: 16,right: index==Portrait.wall.length-1?16:0),
                            decoration: BoxDecoration(image:DecorationImage(
                                image: NetworkImage(eachPhoto.src!.portrait.toString()),fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20),
                            )
                        ),
                      );
                    }
                ),
              ),
              SizedBox(height: 11,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("The color tone",style: mTextStyle16(mFontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 7,),
              Container(height: 50,width:double.infinity,
                  child:ListView.builder(itemCount: ColorPage.kamal.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_,index)
                      {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            BlocProvider(create: (context)=>SearchBloc(wallPaperRepository: WallPaperRepository(apiHelper: ApiHelper())),
                              child: SearchWallPage(
                                query:wallController.text.isNotEmpty ? wallController.text:"Nature",
                                color: ColorPage.kamal[index]['Code']))
                            ));
                          },
                          child: Container(height: 50,width: 50,
                            margin: EdgeInsets.only(left: 16,right: index==ColorPage.kamal.length-1?16:0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),
                              color:ColorPage.kamal[index]['WallPaper'],),
                          ),
                        );
                      })
              ),
              SizedBox(height: 11,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: Text("Categories",style: mTextStyle16(mFontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 11,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 11,
                    childAspectRatio: 9/4,
                    crossAxisSpacing: 11,
                  ),
                  itemCount: LandScape.pic.length,
                  itemBuilder: (_,index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        BlocProvider(create: (context)=>SearchBloc(wallPaperRepository: WallPaperRepository
                          (apiHelper: ApiHelper())),
                          child: SearchWallPage(query: LandScape.pic[index]['title']),)
                        ));
                      },
                      child: Container(height: 100,width: 200,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),
                            image: DecorationImage(image: AssetImage(LandScape.pic[index]["WallPaper"]),fit:BoxFit.cover)
                        ),
                        child: Center(
                          child:Text(LandScape.pic[index]['title'],style: mTextStyle16(mColor: Colors.white,mFontWeight: FontWeight.bold),),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
        return Container();
      })
    );
  }
}























































/*
Container(padding: EdgeInsets.only(top: 20),
width: double.infinity,//color:Colors.brown,
child:
Column(
children: [
Container(
height:400,
child: Column(
children: [
SizedBox(height: 10,),
Row(children: [
Text("The color tone",style: TextStyle(fontSize: 25,
fontWeight: FontWeight.bold),)
],),
// SizedBox(height: 10,),
Column(children: [
ListView.builder(itemCount: ColorPage.kamal.length,
itemBuilder: (_,index)
{
return Container(width: 30,height: 30,
color:ColorPage.kamal[index]['WallPaper'],
);
})

],)
],
),),
Container(height: 400,
child: Column(
children: [
SizedBox(height: 10,),
Row(children: [
Text("The color tone",style: TextStyle(fontSize: 25,
fontWeight: FontWeight.bold),)
],),
// SizedBox(height: 10,),
Column(children: [
ListView.builder(itemCount: ColorPage.kamal.length,
itemBuilder: (_,index)
{
return Container(width: 30,height: 30,
color:ColorPage.kamal[index]['WallPaper'],
);
})

],)
],

),
)

],
),
),*/
