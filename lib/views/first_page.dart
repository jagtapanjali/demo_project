import 'package:demo/views/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/size_constants.dart';
import '../product/product_controller.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);

  final ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    SizeConstants.setScreenAwareConstant(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Page"),
        backgroundColor: Color.fromRGBO(35, 35, 42, 1.0),
      ),
      body: SafeArea(
        child: Obx(() => Container(
              color: Color.fromRGBO(35, 35, 42, 1.0),
              child: _productController.products!.obs.value.isNotEmpty
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _productController.products!.obs.value.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 20,
                            color: Color.fromRGBO(41, 41, 43, 1.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(41, 41, 43, 1.0),
                                  //border: Border.all(color: Colors.black)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Text(
                                        "${_productController.products!.obs.value.elementAt(index)['name']}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'RobotoMono',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(20),
                                    ),
                                    Image.network(
                                      _productController.products!
                                          .elementAt(index)
                                          .obs
                                          .value['image']
                                          .split(",")[0],
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: Text(
                                        'Country : ${_productController.products!.elementAt(index).obs.value['country']}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'RobotoMono',
                                            overflow: TextOverflow.fade),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: Text(
                                        'Engines : ${_productController.products!.elementAt(index).obs.value['engine_count']}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'RobotoMono',
                                            overflow: TextOverflow.fade),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => SecondPage(
                                                _productController.products!
                                                    .elementAt(index)));
                                          },
                                          child: Card(
                                            elevation: 29,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                              //set border radius more than 50% of height and width to make circle
                                            ),
                                            color: const Color.fromRGBO(
                                                65, 65, 73, 1.0),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 10, 15, 10),
                                              child: Text(
                                                'More Details >>',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'RobotoMono',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                  : const Center(
                      child: Text(
                        "No data",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          color: Colors.white,
                        ),
                      ),
                    ),
            )),
      ),
    );
  }
}
