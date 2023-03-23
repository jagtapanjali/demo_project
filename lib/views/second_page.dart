import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/size_constants.dart';

class SecondPage extends StatefulWidget {
  Map<dynamic, dynamic>? products;

  SecondPage(this.products, {Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState(products: products);
}

class _SecondPageState extends State<SecondPage> {
  Map<dynamic, dynamic>? products;
  String? active_status;

  _SecondPageState({this.products});

  @override
  void initState() {
    active_status = products!['active'] == 1 ? 'True' : 'False';
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConstants.setScreenAwareConstant(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 42, 1.0),
      appBar: AppBar(
        title: const Text("Second Page"),
        backgroundColor: Color.fromRGBO(35, 35, 42, 1.0),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Center(
                      child: Flexible(
                        child: Text(
                          "${products!['name']}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'RobotoMono',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    products!['image'].split(',').isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Card(
                              elevation: 20,
                              color: const Color.fromRGBO(55, 55, 59, 1.0),
                              child: Container(
                                height: ScreenUtil().setHeight(200),
                                child: ImageSlideshow(
                                  indicatorColor: Colors.white,
                                  indicatorRadius: 5,
                                  children: List<Widget>.generate(
                                    products!['image'].split(',').length,
                                    (i) {
                                      return Image.network(
                                        products!['image'].split(',')[i],
                                        fit: BoxFit.fitWidth,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Text(
                    //       "${products!.rating}",
                    //       style: const TextStyle(
                    //           fontFamily: 'RobotoMono', color: Colors.white),
                    //     ),
                    //     const Icon(
                    //       Icons.star,
                    //       color: Colors.yellow,
                    //     ),
                    //     SizedBox(
                    //       width: ScreenUtil().setWidth(10),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  'Active Status: ${active_status!}',
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.w300,
                      overflow: TextOverflow.fade),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  ' ${products!['description']}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'RobotoMono',
                      overflow: TextOverflow.fade),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  'Price: ${products!['costPerLaunch']} ₹',
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  'Success Rate: ${products!['successRatePct']} %',
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      'Height: ${products!['height_feet']} feet',
                      style: const TextStyle(
                          color: Colors.deepOrange,
                          fontFamily: 'RobotoMono',
                          overflow: TextOverflow.fade),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      'Height: ${products!['height_meters']} meters',
                      style: const TextStyle(
                          color: Colors.deepOrange,
                          fontFamily: 'RobotoMono',
                          overflow: TextOverflow.fade),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      'Diameter: ${products!['diameter_feet']} feet',
                      style: const TextStyle(
                          color: Colors.deepOrange,
                          fontFamily: 'RobotoMono',
                          overflow: TextOverflow.fade),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      'Diameter: ${products!['diameter_meters']} meters',
                      style: const TextStyle(
                          color: Colors.deepOrange,
                          fontFamily: 'RobotoMono',
                          overflow: TextOverflow.fade),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _launchURL('${products!['wikipedia']}');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Card(
                      elevation: 29,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      color: const Color.fromRGBO(65, 65, 73, 1.0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Center(
                          child: Flexible(
                            child: Text(
                              'Go to Wikipedia Link >>',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 19,
                                fontFamily: 'RobotoMono',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
