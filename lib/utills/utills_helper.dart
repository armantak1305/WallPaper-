import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors
{
  /// light
   static final primaryLightColor = Color(0xffddebf2);
   static final secondaryLightColor = Color(0xffeef3f5);
   static final mainColor = Color(0xff3f64f4);
}

TextStyle mTextStyle12({Color mColor = Colors.black ,mFontWeight = FontWeight.normal})
{
  return TextStyle(fontSize: 12,fontWeight: mFontWeight,color: mColor,fontFamily:'mainFont');
}

TextStyle mTextStyle14({Color mColor = Colors.black,mFontWeight = FontWeight.normal})
{
    return TextStyle(color: mColor,fontFamily: 'main font',fontWeight: FontWeight.normal,fontSize: 14);
}

TextStyle mTextStyle16({Color mColor=Colors.black,mFontWeight=FontWeight.normal})
{
  return TextStyle(fontSize: 16,fontWeight: mFontWeight,color: mColor,fontFamily:'main font');
}

TextStyle mTextStyle35({Color mColor =Colors.black,mFontWeight=FontWeight.normal})
{
  return TextStyle(fontFamily: 'main font',fontWeight: mFontWeight,color: mColor,fontSize: 35);
}


Column mColumn({required IconData? mIcon,required String? title,
  required VoidCallback? onTap,Color? bgColor})
{
  return Column(mainAxisAlignment: MainAxisAlignment.end,
    children: [
      InkWell(
        onTap: onTap,
        child: Container(
          height: 70,width: 70,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: bgColor != null ? Colors.blueAccent : Colors.white.withOpacity(0.4)
          ),
          child:Center(child: Icon(mIcon,color: Colors.white,size: 28,),),
        ),
      ),
      SizedBox(height: 2,),
      Text(title.toString(),style: mTextStyle12(mColor: Colors.white,),)
    ],
  );
}