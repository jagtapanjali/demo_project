import 'package:demo/api_helper/apis.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../Database/product_database.dart';

class ProductController extends GetxController {
  RxList<Map<dynamic, dynamic>>? products = <Map<dynamic, dynamic>>[].obs;

  @override
  void onInit() {
    getProducts();
  }

  Future<void> getProducts() async {
    dio.Response response = await APIs().fetchRockets();
    if (response != null) {
      await ProductDatabase().setDatabase();
      print("json===${response}");
      //List<Products>? productList = List<Products>.from(jsonDecode(response.data.join('')).map((model)=> Products.fromJson(model)));
      List<dynamic>? productList = response.data!;
      print("===product ${productList!.elementAt(0)}");
      //Products products = Products.fromJson(response);
      //final List<Products>? productList = jsonDecode(response.data.toString());
      for (int i = 0; i < productList.length; i++) {
        await ProductDatabase.productDatabase!.insert(
            'Product',
            {
              'id': productList.elementAt(i)['id'],
              'name': productList.elementAt(i)['name'],
              'image': productList.elementAt(i)['flickr_images'].join(","),
              'description': productList.elementAt(i)['description'],
              'costPerLaunch': productList.elementAt(i)['cost_per_launch'],
              'country': productList.elementAt(i)['country'],
              'engine_count': productList.elementAt(i)['engines']['number'],
              'active': productList.elementAt(i)['active'] == true ? 1 : 0,
              'successRatePct': productList.elementAt(i)['success_rate_pct'],
              'wikipedia': productList.elementAt(i)['wikipedia'],
              'height_feet': productList.elementAt(i)['height']['feet'],
              'height_meters': productList.elementAt(i)['height']['meters'],
              'diameter_feet': productList.elementAt(i)['diameter']['feet'],
              'diameter_meters': productList.elementAt(i)['diameter']['meters'],
            },
            conflictAlgorithm: ConflictAlgorithm.ignore);
      }
      products!.value = await ProductDatabase().getTableInList();
      print("====${products!.obs.value}");
    }
  }
}
