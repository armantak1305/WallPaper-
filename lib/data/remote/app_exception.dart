class AppException implements Exception
{
   String? title;
   String? msg;
   AppException({required this.msg,required this.title});
   String toErrorMsg()
   {
     return "$title:$msg";
   }
}

class FetchException extends AppException{
  FetchException({required String errorMsg}):super(title: "Network Error",msg: errorMsg);
}

class BadRequestException extends AppException{
  BadRequestException({required String errorMsg}):super(title: "Invalid Request",msg: errorMsg);
}

class UnAuthorisedException extends AppException{
  UnAuthorisedException({required String errorMsg }):super(title: "UnAuthorised",msg: errorMsg);
}

class InvalidInputException extends AppException{
  InvalidInputException({required String errorMsg}):super(title: "Invalid User",msg: errorMsg);
}