import 'package:capstone/wiget/bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class Interestlistpage extends StatelessWidget {
  const Interestlistpage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;
    return MaterialApp(
      title: 'InterestListPage',
      debugShowCheckedModeBanner: false,
      home: InterList(),
    );
  }
}

class InterList extends StatelessWidget {
  const InterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '관심목록',
            style: TextStyle(
              fontFamily: 'skybori',
              fontSize: 30,
              letterSpacing: 2.0,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            Image.asset('assets/images/skon_fly.png'),
            SizedBox(width: 20),
          ],
          shape: Border(
              bottom: BorderSide(
            color: Colors.grey,
            width: 0.8,
          )),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 0.0),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Image.asset('assets/images/book.jfif',
                        width: 66, height: 66, fit: BoxFit.contain),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text('운영체제 공룡책1',
                            style: TextStyle(
                              fontFamily: 'skybori',
                              fontSize: 20,
                              letterSpacing: 1.0,
                            )),
                        Row(
                          children: [
                            Text('소프트웨어학과',
                                style: TextStyle(
                                  fontFamily: 'skybori',
                                  fontSize: 15,
                                  color: Color.fromRGBO(140, 140, 140, 1),
                                )),
                            Text(' · ',
                                style: TextStyle(
                                  fontFamily: 'skybori',
                                  fontSize: 15,
                                  color: Color.fromRGBO(140, 140, 140, 1),
                                )),
                            Text('3일전',
                                style: TextStyle(
                                  fontFamily: 'skybori',
                                  fontSize: 15,
                                  color: Color.fromRGBO(140, 140, 140, 1),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 50.0,
                  color: Color(0xffD0E4BC),
                  thickness: 1.0,
                  endIndent: 30.0,
                ),
                Row(
                  children: [
                    Image.asset('assets/images/book.jfif',
                        width: 66, height: 66, fit: BoxFit.contain),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text('운영체제 공룡책2',
                            style: TextStyle(
                              fontFamily: 'skybori',
                              fontSize: 20,
                              letterSpacing: 1.0,
                            )),
                        Row(
                          children: [
                            Text('소프트웨어학과',
                                style: TextStyle(
                                  fontFamily: 'skybori',
                                  fontSize: 15,
                                  color: Color.fromRGBO(140, 140, 140, 1),
                                )),
                            Text(' · ',
                                style: TextStyle(
                                  fontFamily: 'skybori',
                                  fontSize: 15,
                                  color: Color.fromRGBO(140, 140, 140, 1),
                                )),
                            Text('3일전',
                                style: TextStyle(
                                  fontFamily: 'skybori',
                                  fontSize: 15,
                                  color: Color.fromRGBO(140, 140, 140, 1),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 50.0,
                  color: Color(0xffD0E4BC),
                  thickness: 1.0,
                  endIndent: 30.0,
                ),
                Row(
                  children: [
                    Image.asset('assets/images/book.jfif',
                        width: 66, height: 66, fit: BoxFit.contain),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text('운영체제 공룡책3',
                            style: TextStyle(
                              fontFamily: 'skybori',
                              fontSize: 20,
                              letterSpacing: 1.0,
                            )),
                        Row(
                          children: [
                            Text('소프트웨어학과',
                                style: TextStyle(
                                  fontFamily: 'skybori',
                                  fontSize: 15,
                                  color: Color.fromRGBO(140, 140, 140, 1),
                                )),
                            Text(' · ',
                                style: TextStyle(
                                  fontFamily: 'skybori',
                                  fontSize: 15,
                                  color: Color.fromRGBO(140, 140, 140, 1),
                                )),
                            Text('3일전',
                                style: TextStyle(
                                  fontFamily: 'skybori',
                                  fontSize: 15,
                                  color: Color.fromRGBO(140, 140, 140, 1),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 50.0,
                  color: Color(0xffD0E4BC),
                  thickness: 1.0,
                  endIndent: 30.0,
                ),
              ],
            )
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar());
  }
}
