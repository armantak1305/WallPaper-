import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as httpApi;
import 'app_exception.dart';
class ApiHelper
{
  Future<dynamic> getApi({required String url})
  async{
       var uri = Uri.parse(url);
      try{
        var res = await httpApi.get(uri,headers:
        {
           "Authorization":"q0ez1K8AYb0RZMFV9jyhd8l5aXrcrfeCZfGhwxT4XwIsYAZHlXdSklZS"
        });
        return returnJsonRes(res);
      }on SocketException catch(e){
        throw FetchException(errorMsg: "No Internet !!");

      }
  }
}
           dynamic returnJsonRes(httpApi.Response response)
           {
             switch(response.statusCode){
               case 200:{
                 var mData = jsonDecode(response.body);
                 return mData;}
               case 400:throw BadRequestException(errorMsg: "${response.body.toString()}");
               case 401:
               case 403:
                 throw UnAuthorisedException(errorMsg: "${response.body.toString()}");
               case 500:
                 default:
                   throw FetchException(errorMsg: "Error Occurred while Communication with server with StatusCode :"
                       "${response.statusCode}");
             }
           }