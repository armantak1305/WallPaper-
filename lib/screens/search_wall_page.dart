import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/screens/detail_page.dart';
import '../data/bloc/searchBloc/search_bloc.dart';
import '../data/bloc/searchBloc/search_event.dart';
import '../data/bloc/searchBloc/search_state.dart';
import '../model/wallPaper_model.dart';
import '../utills/utills_helper.dart';

class SearchWallPage extends StatefulWidget
{
  String query;
  String color;
  SearchWallPage({required this.query,this.color=''});

  @override
  State<SearchWallPage> createState() => _SearchWallPageState();
}

class _SearchWallPageState extends State<SearchWallPage>
{
  ScrollController? scrollController;
  num totalWallPaperCount=0;
  int totalNoPages=1;
  int pageCount=1;
  List<PhotosModel>allPaper=[];
  @override
  void initState()
  {
    super.initState();
    context.read<SearchBloc>().add(WallSearchEvent(query: widget.query,color: widget.color,));

  }
  @override
  Widget build(BuildContext context)
  {
    scrollController=ScrollController();
    scrollController!.addListener((){
      if(scrollController!.position.pixels==scrollController!.position.maxScrollExtent)
      {
        print("End of Content");
        totalNoPages = totalWallPaperCount~/15+1;
        if(totalNoPages>pageCount)
        {
          pageCount++;
          context.read<SearchBloc>().add(WallSearchEvent(query: widget.query,color: widget.color,page: pageCount));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You\'ve reached the end of category wallpapers !!")));
        }
      }
    });
   // context.read<SearchBloc>().add(WallSearchEvent(query: widget.query,color: widget.color,page: pageCount));
   return Scaffold(backgroundColor: AppColors.primaryLightColor,
     body:BlocListener<SearchBloc,SearchState>(
         listener: (_,state)
     {
       if(state is SearchLoadingState)
       {
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(pageCount != 1 ? "Next page loading...":"Loading....")));
       }else if(state is SearchErrorState){
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(state.ErrorMsg)));
       }else if(state is SearchLoadedState)
       {
         totalWallPaperCount= state.wallPaperDataModel.total_results!;
         allPaper.addAll(state.wallPaperDataModel.photos!);
        // var mData = state.wallPaperDataModel;
         setState(() {
         });
       }
     },child:  Padding(
     padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
     child: ListView(
         controller: scrollController,
         children:[
           Text(widget.query,style:mTextStyle35(mFontWeight: FontWeight.bold,mColor: Colors.black) ),
           Text("$totalWallPaperCount wallpaper available",style:mTextStyle16()),
           SizedBox(height: 20,),
           GridView.builder(
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 crossAxisSpacing: 15,
                 childAspectRatio: 2/3,
                 mainAxisSpacing: 15
             ),
             itemCount: allPaper.length,
             itemBuilder: (_,index){
               var eachData = allPaper[index];
               return InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(srcModel: eachData.src!)));
                 },
                 child: Container(
                   height: 450,width: 100,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       image: DecorationImage(image: NetworkImage(eachData.src!.portrait.toString()),fit: BoxFit.cover)),
                 ),
               );
             },
           ),
         ] ),)
     )
   );
  }
}














/*

{
if(state is SearchLoadingState){
return Center(child: CircularProgressIndicator(),);
}else if(state is SearchErrorState){
return Center(child: Text(state.ErrorMsg),);
}else if(state is SearchLoadedState){
totalWallPaperCount= state.wallPaperDataModel.total_results!;
allPaper.addAll(state.wallPaperDataModel.photos!);
var mData = state.wallPaperDataModel;
return  Padding(
padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
child: ListView(
controller: scrollController,
children:[
Text(widget.query,style:mTextStyle35(mFontWeight: FontWeight.bold,mColor: Colors.black) ),
Text("${mData.total_results} wallpaper available",style:mTextStyle16()),
SizedBox(height: 20,),
GridView.builder(
shrinkWrap: true,
physics: NeverScrollableScrollPhysics(),
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
crossAxisSpacing: 15,
childAspectRatio: 2/3,
mainAxisSpacing: 15
),
itemCount: allPaper.length,
itemBuilder: (_,index){
var eachData = allPaper[index];
return InkWell(
onTap: (){
},
child: Container(
height: 450,width: 100,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
image: DecorationImage(image: NetworkImage(eachData.src!.portrait.toString()),fit: BoxFit.cover)),
),
);
},
),
] ),
);
}
return Container();
}*/
