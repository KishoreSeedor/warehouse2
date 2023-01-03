import 'package:warehouse/const/config.dart';

Uri UriConverter(String url) {
  Uri data = Uri.parse(url);
  return data;
}

AllApiCallsName allApiCallsName = AllApiCallsName();

class AllApiCallsName {
  String loginApiCallName = '$baseApiUrl/seedor-app-login';
  String loginProfileGetApiName = '$baseApiUrl/seedor-api-profile';
}
