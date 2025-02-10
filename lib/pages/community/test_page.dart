import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_store/model/data.dart';
import 'package:flutter_store/model/entry.dart';
import 'package:flutter_store/model/explore_rsp.dart';
import 'package:flutter_store/model/image.dart';
import 'package:flutter_store/model/items.dart';
import 'package:flutter_store/model/product.dart';
import 'package:flutter_store/network/api.dart';
import 'package:http/http.dart' as http;

import '../../model/entrys.dart';
import '../../utils/XMColor.dart';
import '../../widget/tile_card.dart';
import 'keep_alive_wrapper.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>{
  //late TabController _tabController;
  //List tabs = ["新闻", "历史", "图片"];

  //late TabController tabCtr;
  List tabs = ['热门', '关注', '话题', '同城'];
  num errorCode = -1;
  String lastId = "";
  List<Entry> EntryItems = [];
  List<Items> exploreItems = [];
  Map<String, dynamic>? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_tabController = TabController(length: tabs.length, vsync: ScrollableState());
    _handleRefresh();
  }

  Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }

  Future<Null> _handleRefresh() async {
    Map<String, dynamic> StudentData = await loadJsonFromAssets('json/test.json');
    var test1 = Product.fromJson(StudentData);
    print("test1 = ${test1.id}");
    print("test1 = ${test1.name}");
    var test2 = test1.images![0].id;
    print("test2 = ${test2}");
    var test3 = test1.images![0].imageName;
    print("test3 = ${test3}");


    try{
      var response = await http.get(Uri.parse(Api.baseUrl),);
      setState(() {
        if (response.statusCode == 200) { //如果讀取成功
          print("OK");
          //Map<String, dynamic> fetchedData = jsonDecode(response.body); //取得讀取到的資料
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

         // img: "https://static1.keepcdn.com/picture/2023/06/28/08/41/64f9486f127d33e95ac581ba7511ce5db58daf9c_1133x1510.jpg",
          // content: "湘纯子每日美食分享😋",
        //avatar: "https://static1.keepcdn.com/avatar/2022/09/29/22/14/e8422df7c4e66211583bcf804933031d9f9f1886.jpg",
        //name: "路哥之彪悍人生",
        //likes: exploreItems[index].entry!.likes.toString(),
         /* data =  Explore_rsp.fromJson(result1).data!;
          print("data[lastId] = ${data!["lastId"]}");
          print("data[items] = ${data!["items"]}");
          print("data[items][0] = ${data!["items"][0]}");
          print("data[items][0] = ${data!["items"][0].entry}");*/

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
    //_handleRefresh();

    return Scaffold(
      backgroundColor: XMColor.bgGray,
      appBar: AppBar(title: const Text("TestPage"),),
      body: Container(
        child: _gridView(),
      ),
      /*body: Center(
        child: MasonryGridView.count(
          crossAxisCount: 1, //几列
          mainAxisSpacing: 4, // 间距
          crossAxisSpacing: 4, // 纵向间距？
          itemCount: 8,//元素个数
          itemBuilder: (context,index){
            //return Text("ind = ${index}");

            int numIndex = 0+index;
            var img = exploreItems[numIndex].entry!.images![0] ?? Api.avatar;
            var content = exploreItems[numIndex].entry!.sampleComments![0].content ?? "默认测试内容";
            var avatar = exploreItems[numIndex].entry!.sampleComments![0].author!.avatar ?? Api.avatar;
            //var img = Api.avatar;
            //var content = "默认测试内容";
            /*var avatar;
            if(exploreItems[numIndex].entry!.sampleComments![0].author!.avatar == null){
              avatar = Api.avatar;
            }else{
              avatar = exploreItems[numIndex].entry!.sampleComments![0].author!.avatar;
            }*/
            var name = exploreItems[numIndex].entry!.sampleComments![0].author!.username ?? "無名";
            var likes = (exploreItems[numIndex].entry!.likes ?? 0).toString();
            return TileCard(
              img: img,
              content: content,
              avatar: avatar,
              name: name,
              likes: likes,
            );
            /*return TileCard(
              img: "https://static1.keepcdn.com/picture/2023/06/28/08/41/64f9486f127d33e95ac581ba7511ce5db58daf9c_1133x1510.jpg",
              content: "湘纯子每日美食分享😋",
              avatar: "https://static1.keepcdn.com/avatar/2022/09/29/22/14/e8422df7c4e66211583bcf804933031d9f9f1886.jpg",
              name: "路哥之彪悍人生",
              likes: "5",
              isVip: true,
            );*/
          },
        ),
      ),*/


      /*body: ListView(
        children: [
          /*TileCard(
            img: "https://static1.keepcdn.com/picture/2023/06/28/08/41/64f9486f127d33e95ac581ba7511ce5db58daf9c_1133x1510.jpg",
            content: "湘纯子每日美食分享😋",
            avatar: "https://static1.keepcdn.com/avatar/2022/09/29/22/14/e8422df7c4e66211583bcf804933031d9f9f1886.jpg",
            name: "路哥之彪悍人生",
            likes: "5",
            isVip: true,
          ),*/
          /*TileCard(
            img: "https://static1.keepcdn.com/picture/2023/06/28/09/21/95cfa6fffc52a3375bc09435fe6e43550e4e4874_1247x1662.jpg",
            content: "纯子姐姐营养美味的早餐",
            avatar: "https://static1.keepcdn.com/user-avatar/2024/10/08/21/5a23938c7511ce15a1048460/69529e3d18892c2890fcb89a47a71e29_1023x1023.jpg",
            name: "公主变美",
            likes: "6",
            isVip: true,
          ),*/
          Container(height: 50,color: Colors.redAccent,),
          Container(height: 50,color: Colors.blueGrey,),
          Container(
            color: XMColor.bgGray,
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: EasyRefresh(
              onRefresh: _handleRefresh,
              onLoad: _handleRefresh,
              child: _gridView(),
            ),
          ),
        ],
      ),*/
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
    /*return Center(
      /*child: MasonryGridView.count(
        crossAxisCount: 1, //几列
        mainAxisSpacing: 4, // 间距
        crossAxisSpacing: 4, // 纵向间距？
        itemCount: 8,//元素个数
        itemBuilder: (context,index){
          //return Text("ind = ${index}");

          int numIndex = 0+index;
          var img = exploreItems[numIndex].entry!.images![0] ?? Api.avatar;
          var content = exploreItems[numIndex].entry!.sampleComments![0].content ?? "默认测试内容";
          var avatar = exploreItems[numIndex].entry!.sampleComments![0].author!.avatar ?? Api.avatar;
          //var img = Api.avatar;
          //var content = "默认测试内容";
          /*var avatar;
            if(exploreItems[numIndex].entry!.sampleComments![0].author!.avatar == null){
              avatar = Api.avatar;
            }else{
              avatar = exploreItems[numIndex].entry!.sampleComments![0].author!.avatar;
            }*/
          var name = exploreItems[numIndex].entry!.sampleComments![0].author!.username ?? "無名";
          var likes = (exploreItems[numIndex].entry!.likes ?? 0).toString();
          return TileCard(
            img: img,
            content: content,
            avatar: avatar,
            name: name,
            likes: likes,
          );
          /*return TileCard(
              img: "https://static1.keepcdn.com/picture/2023/06/28/08/41/64f9486f127d33e95ac581ba7511ce5db58daf9c_1133x1510.jpg",
              content: "湘纯子每日美食分享😋",
              avatar: "https://static1.keepcdn.com/avatar/2022/09/29/22/14/e8422df7c4e66211583bcf804933031d9f9f1886.jpg",
              name: "路哥之彪悍人生",
              likes: "5",
              isVip: true,
            );*/
        },
      ),*/
    );*/
  }



}
