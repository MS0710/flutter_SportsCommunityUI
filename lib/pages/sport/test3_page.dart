import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_store/pages/sport/sport_data.dart';

import '../../utils/XMColor.dart';
import '../../utils/relative_date_format.dart';
import '../../utils/screen.dart';

class Test3Page extends StatefulWidget {
  const Test3Page({super.key});

  @override
  State<Test3Page> createState() => _Test3PageState();
}

class _Test3PageState extends State<Test3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "運動",
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Container(
            width: 35,
            height: 35,
            child: IconButton(
              icon: Image.asset('assets/images/sport_nav_right_kxwy.png'),
              onPressed: () {
                print('k星物语');
              },
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 35,
            height: 35,
            child: IconButton(
              icon: Image.asset('assets/images/sport_nav_right_wristband.png'),
              onPressed: () {
                print('keep手环');
              },
            ),
          ),
          Container(
            width: 35,
            height: 35,
            child: IconButton(
              icon: Image.asset('assets/images/sport_nav_right_search.png'),
              onPressed: () {
                print('搜索');
              },
            ),
          ),
        ],
      ),

      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 16,
                  height: 44,
                ),
                Text(
                  '下午好，',
                  style: TextStyle(color: XMColor.lightGray, fontSize: 14),
                ),
                Text(
                  sportData['userInfo']['name'],
                  style: TextStyle(color: XMColor.lightGray, fontSize: 16),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(18, 10, 0, 16),
              child: Row(
                children: [
                  Image(
                    height: 18,
                    image: AssetImage('assets/images/sport_set_goals.png'),
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 12,),
                  Text(
                    '订个目标 ，开始Keep! ',
                    style: TextStyle(
                      color: XMColor.deepGray,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1,),
            ListTile(
              title: Text(
                '已累计运动1862分钟',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Container(
                width: xmDp(22),
                height: xmDp(44),
                child: Image(
                  image: AssetImage('assets/images/comm_detail.png'),
                ),
              ),
            ),
          ],
        ),
        _grayGap(),
        _myTeam(),
        _grayGap(),
        _myClass(),
        _grayGap(),
        _eventPromotion(),
      ],
    );
  }

  _grayGap() {
    return Container(
      height: xmDp(22),
      color: XMColor.bgGray,
    );
  }
  _myTeam() {
    Map sec1 = sportData['sections'][1];
    Map squad = sec1['squad'];
    Map week = squad['week'];
    String des = '第 ${week['weekIndex']} 周：   ${week['introduction']}';
    List teams = squad['dynamicItems'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          child: ListTile(
              title: Text(
                sec1['sectionName'],
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(52),
                  color: Colors.black,
                ),
              )
          ),
        ),
        Container(
          width: Screen.width,
          padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(squad['picture']),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                title: Text(
                  squad['name'],
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(54), color: Colors.white),
                ),
                subtitle: Text(
                  des,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(32), color: Colors.white),
                ),
                trailing: Container(
                  width: xmDp(60),
                  height: xmDp(60),
                  child: Image.asset('assets/images/explore_class_section_right.png',
                      fit: BoxFit.fill),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: Screen.width - 20 * 2,
                height: 50,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    _finishedTeamers(teams)[0],
                    _finishedTeamers(teams)[1],
                    _finishedTeamers(teams)[2],
                    Positioned(
                      left: 80,
                      child: Container(
                        height: 30,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/images/sport_punch.png',
                              fit: BoxFit.cover,
                            ),
                            Text(
                              '完成了今天全部打卡',
                              style:
                              TextStyle(color: Colors.white, fontSize: 11),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      child: InkWell(
                        onTap: () {
                          print('加油加油!');
                        },
                        child: Container(
                          height: 30,
                          child: Image.asset(
                            'assets/images/sport_like.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
  _myClass() {
    Map sec3 = sportData['sections'][3];
    List cls = sec3['joinedCoursesV2'];
    return Column(
      children: [
        _sectionView(sec3['sectionName'], true),
        Container(
          child: Column(
            children: cls.map((v){
              var diffTime = RelativeDateFormat.format(
                  DateTime.parse(v['lastTrainingDate']));
              bool isVip = v['hasPlus'];
              return Column(
                children: [
                  SizedBox(height: 15),
                  Container(
                    height: 24,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 24,
                        ),
                        Text(
                          v['name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        isVip ? Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Color(0xffe9d399),
                              borderRadius: BorderRadius.circular(3)),
                          child: Text(
                            '会员精讲',
                            style: TextStyle(fontSize: 10),
                          ),
                        ):Text(''),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${v['averageDuration']} 分钟 · K${v['difficulty']}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(width: 16, height: 48,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 24,
                    child: Row(
                      children: [
                        SizedBox(width: 16,),
                        Text(
                          '上次训练 $diffTime  ${v['liveUserCount']}人正在练',
                          style: TextStyle(
                            fontSize: 12,
                            color: XMColor.lightGray,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '已下载',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 16, height: 48,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    height: 1,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
  _eventPromotion() {
    Map secInfo = sportData['sections'][4];
    List promotions = secInfo['promotions'];
    return Column(
      children: [
        _sectionView(secInfo['sectionName'], false),
        CarouselSlider(
          items: promotions.map((v){
            var img = v['picture'];
            return Builder(builder: (BuildContext context){
              return Container(
                padding: EdgeInsets.fromLTRB(
                    xmDp(30), xmDp(30), xmDp(30), xmDp(10)),
                child: ListView(
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      width: xmDp(200- 10 * 2),
                      child: ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: img,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      v['title'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      v['text'],
                      style:
                      TextStyle(fontSize: 14, color: XMColor.lightGray),
                    ),
                  ],
                ),
              );
            }
            );

          }).toList(),
          options: CarouselOptions(
            height: 280.0,
            viewportFraction: 1.0,
            aspectRatio: 2.0,
            autoPlay: false,
            enlargeCenterPage: false,
          ),
        ),
        Container(
          width: Screen.width,
          height: 44,
          color: XMColor.bgGray,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('- 没有更多了 -',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: XMColor.deepGray),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _finishedTeamers(teams) {
    return teams.map((v) {
      double w = 30;
      int idx = teams.indexOf(v);
      double x = (w - 10) * (2 - idx.toDouble());
      return Positioned(
        left: x,
        width: w,
        height: w,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )),
          child: CircleAvatar(
            backgroundImage: NetworkImage(v['avatar']),
            radius: 20,
          ),
        ),
      );
    }).toList();
  }
  _sectionView(title, bool showDetail) {
    return InkWell(
      onTap: () {
        setState(() {
          // widget.inde = 1;
        });
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            width: xmDp(28),
            height: xmDp(78),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(52), color: XMColor.deepGray),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: showDetail
                      ? Container(
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                    decoration: BoxDecoration(
                        color: Color(0xff5fc48f),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      '发现课程',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
                      : Text(''),
                ),
                SizedBox(
                  width: xmDp(28),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
