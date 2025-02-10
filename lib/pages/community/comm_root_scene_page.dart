import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

import '../../model/entry.dart';
import '../../model/entrys.dart';
import '../../model/explore_rsp.dart';
import '../../model/items.dart';
import '../../network/api.dart';
import '../../utils/XMColor.dart';
import '../../utils/screen.dart';
import '../../utils/toast.dart';
import '../../widget/tile_card.dart';
import '../../widget/xmtext.dart';

class CommRootScenePage extends StatefulWidget {
  const CommRootScenePage({super.key});

  @override
  State<CommRootScenePage> createState() => _CommRootScenePageState();
}

class _CommRootScenePageState extends State<CommRootScenePage>{
  bool _showCancel = false;
  TextEditingController searchCtr = TextEditingController();
  List tabs = ['热门', '关注', '话题', '同城'];
  int _position = 0; //表示从第几条开始取
  List<Entrys> posts = [];
  /////////
  final double titleFontSize = 16.0;
  num errorCode = -1;
  String lastId = "";
  List<Entry> EntryItems = [];
  List<Items> exploreItems = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleRefresh();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }

  Future<Null> _handleRefresh() async {
    try{
      var response = await http.get(Uri.parse(Api.baseUrl),);
      setState(() {
        if (response.statusCode == 200) { //如果讀取成功
          print("OK");

          Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
          var result1 = json.decode(utf8decoder.convert(response.bodyBytes));
          errorCode = Explore_rsp.fromJson(result1).errorCode!;
          print("errorCode = $errorCode");
          print("errorCode = ${Explore_rsp.fromJson(result1).data!.lastId}");
          print("errorCode = ${Explore_rsp.fromJson(result1).data!.items![0].entry?.reason}");
          print("errorCode = ${Explore_rsp.fromJson(result1).data!.items![0].entry?.id}");
          exploreItems = Explore_rsp.fromJson(result1).data!.items!;
          print("exploreItems.length = ${exploreItems.length}");
          print("reason = ${exploreItems[0].entry!.reason}");
          print("id = ${exploreItems[0].entry!.id}");
          print("images = ${exploreItems[0].entry!.images![0]}");
          print("images = ${exploreItems[1].entry!.images![0]}");
          print("content = ${exploreItems[0].entry!.sampleComments![0].content}");
          print("content = ${exploreItems[0].entry!.sampleComments![0].author!.avatar}");

          print("content4 = ${exploreItems[4].entry!.sampleComments![0].content}");
          print("username4 = ${exploreItems[4].entry!.sampleComments![0].author!.username}");
          print("content5 = ${exploreItems[5].entry!.sampleComments![0].content}");
          print("username5 = ${exploreItems[5].entry!.sampleComments![0].author!.username}");

        }

      });

    } catch (e) {
      setState(() {
        print(e);
      });
    }
    return null;

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            //title: Text("CommRootScenePage"),
            title: _searchBarWid(),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: _tabBar(),
            ),
            actions: [
              _showCancel
                  ? Container(
                width: 40,
                height: 20,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  //padding: EdgeInsets.all(0),
                  onPressed: () {
                    searchCtr.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      _showCancel = false;
                    });
                  },
                  /*child: XMText.create(
                    '取消',
                    //style: TextStyle(color: Colors.green),
                    color: Colors.green,
                  ),*/
                  child: const Text(
                    '取消',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              )
                  : IconButton(
                icon: new Icon(Icons.person_add),
                color: Colors.grey,
                iconSize: 22.0,
                onPressed: () {
                  Toast.show('添加好友');
                  /*setState(() {
                    _showCancel = true;
                  });*/
                },
              ),
              _showCancel ? SizedBox(width: 10) : Text('')
            ],

          ),

          body: _tabBarView(),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              //commingSoon();
            },
            shape: CircleBorder(),
            child: Image.asset('assets/images/comm_photo.png',),
          ),
        ),
      ),
    );

  }

  Widget _tabBar() {
    return TabBar(
      //controller: tabCtr,
      labelColor: XMColor.darkGray,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      unselectedLabelColor: XMColor.kgray,
      indicatorColor: XMColor.deepGray,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
      tabs: tabs.map((e) => Tab(text: e),).toList(),
    );
  }

  _searchBarWid() {
    return Container(
      //width: xmDp(972),
      //height: xmDp(90),
      child: TextField(
        controller: searchCtr, textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          fillColor: XMColor.contentColor,
          filled: true,
          contentPadding: EdgeInsets.all(2),
          hintText: '搜索',
          hintStyle: TextStyle(color: XMColor.grayColor, fontSize: xmSp(titleFontSize)),
          /*prefixIcon: UnconstrainedBox(
            child:Image.asset('assets/images/comm_search.png',width: 20,),
          ),*/
          prefixIconConstraints: BoxConstraints(minWidth: xmDp(113), maxHeight: xmDp(51)),
          suffixIcon: searchCtr.text.length > 0
              ? GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                searchCtr.text = '';
              },
              child: Icon(
                Icons.cancel,
                color: XMColor.grayColor,
              ))
              : SizedBox(),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(xmDp(50)),
          ),
        ),
        onTap: (){
          setState(() {
            _showCancel = true;
          });
        },
        onSubmitted: (v) {
          Toast.show('搜个毛线啊，没有接口');
          _showCancel = false;
        },
        style: TextStyle(color: Colors.black, fontSize: xmSp(titleFontSize)),
        maxLines: 1,
        onChanged: (v) {
          setState(() {});
        },
      ),
    );
  }
  Widget _tabBarView() {
    return TabBarView(
      //controller: tabCtr,
      children: [
        //Container(child: _refreshView()),
        Container(
          child: _gridView(),
        ),


        GestureDetector(
          onTap: (){},
          child: Column(
            children: [
              SizedBox(height: 10,),
              Image.asset(
                "assets/images/smile.png",
                height: 40,
                width: 40,
              ),
              SizedBox(height: 10,),
              Text("Comming Soon2"),
            ],
          ),
        ),

        GestureDetector(
          onTap: (){},
          child: Column(
            children: [
              SizedBox(height: 10,),
              Image.asset(
                "assets/images/smile.png",
                height: 40,
                width: 40,
              ),
              SizedBox(height: 10,),
              Text("Comming Soon3"),
            ],
          ),
        ),

        GestureDetector(
          onTap: (){},
          child: Column(
            children: [
              SizedBox(height: 10,),
              Image.asset(
                "assets/images/smile.png",
                height: 40,
                width: 40,
              ),
              SizedBox(height: 10,),
              Text("Comming Soon4"),
            ],
          ),
        ),


        /*XMEmpty.show(
          'Comming Soon',
          iconImgPath: imgPath('smile'),
        ),
        XMEmpty.show(
          'Comming Soon',
          iconImgPath: imgPath('smile'),
        ),
        XMEmpty.show(
          'Comming Soon',
          iconImgPath: imgPath('smile'),
        )*/
      ],
    );
  }
  Widget _gridView() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(0),
      //itemCount: 8,
      itemCount: exploreItems.length,
      primary: false,
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      itemBuilder: (context, index) {
        var img;
        var content;
        var avatar;
        var name;
        var likes;

        if(exploreItems[index].entry?.sampleComments?.length == 0){
          img = Api.avatar;
          content ="默认测试内容";
          avatar = Api.avatar;
          name ="無名";
          likes = "0";
        }else{
          img = exploreItems[index].entry!.images![0] ?? Api.avatar;
          content = exploreItems[index].entry!.sampleComments![0].content.toString() ?? "默认测试内容";
          avatar = exploreItems[index].entry!.sampleComments![0].author!.avatar ?? Api.avatar;
          name = exploreItems[index].entry!.sampleComments![0].author!.username ?? "無名";
          likes = (exploreItems[index].entry!.likes ?? 0).toString();
        }

        return TileCard(
          img: img,
          content: content,
          avatar: avatar,
          name: name,
          likes: likes,
        );
      },
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    );
  }


}
