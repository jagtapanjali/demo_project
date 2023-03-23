import 'package:demo/api_helper/api_methods.dart';

class APIs {
  static String baseUrl = "https://api.spacexdata.com/v4/";
  static String rocketApi = "rockets";

  Future fetchRockets() async {
    return await ApiService().get(rocketApi);
  }
}
