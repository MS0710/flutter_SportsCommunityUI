import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store/main_page.dart';
import 'package:flutter_store/pages/community/comm_root_scene_page.dart';
import 'package:flutter_store/pages/community/test_page.dart';
import 'package:flutter_store/pages/community/test_tab_page.dart';
import 'package:flutter_store/pages/explore/explore_page.dart';
import 'package:flutter_store/pages/explore/test2_page.dart';
import 'package:flutter_store/pages/plan/plan_page.dart';
import 'package:flutter_store/pages/sport/sport_page.dart';
import 'package:flutter_store/pages/sport/test3_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    /*return ScreenUtilInit(
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ), // 设置设计稿的尺寸
      builder: (BuildContext context,child) => MaterialApp(
        title: 'Flutter ScreenUtil Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: MainPage(),
        //home: CommRootScenePage(),
        home: SportPage(),
        //home: TestPage(),
        //home: Test2Page(),
        //home: Test3Page(),
      ),
    );*/

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
      //home: PlanPage(),
      //home: Test2Page(),
      //home: ExplorePage(),
      //home: TestPage(),
      //home: CommRootScenePage(),
      //home: TestTabPage(),
      //home: SportPage(),
    );
  }
}

