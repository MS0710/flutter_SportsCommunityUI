import 'package:flutter/material.dart';
import 'package:flutter_store/pages/community/comm_root_scene_page.dart';
import 'package:flutter_store/pages/community/test_page.dart';
import 'package:flutter_store/pages/explore/explore_page.dart';
import 'package:flutter_store/pages/me/me_page.dart';
import 'package:flutter_store/pages/plan/plan_page.dart';
import 'package:flutter_store/pages/sport/sport_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final _defaultColor = const Color(0xff8a8a8a);
  final _activeColor = const Color(0xff50b4ed);
  List<BottomModel> model = [
    BottomModel( "0", "社區"),
    BottomModel( "1", "探索"),
    BottomModel( "2", "運動"),
    BottomModel( "3", "計畫"),
    BottomModel( "4", "我"),
  ];
  final PageController _controller = PageController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("MainPage"),),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: _defaultColor,
        selectedItemColor: _activeColor,
        onTap: (index){
          _currentIndex = index;
          setState(() {
            _controller.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        items: model.map((e) {
          BottomModel bottomModel = e;
          return BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/tab_${bottomModel.iconName}.png',
              width: 24,
              height: 24,
            ),
            activeIcon: Image.asset(
              'assets/images/tab_${bottomModel.iconName}.png',
              width: 24,
              height: 24,
              color: _activeColor,
            ),
            label: bottomModel.label,
          );
        }).toList(),
      ),

      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //TestPage(),
          CommRootScenePage(),
          ExplorePage(),
          //SportPage(),
          //SportPage(),
          SportPage(),
          PlanPage(),
          MePage(),
        ],
      ),
    );

  }
}

class BottomModel{
  final String iconName;
  final String label;

  BottomModel(this.iconName, this.label);
}

