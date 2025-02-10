import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/XMColor.dart';
import '../../utils/screen.dart';
import 'me_data.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      //appBar: AppBar(title: const Text("MePage"),),
      body: Container(
        color: XMColor.bgGray,
        padding: const EdgeInsets.all(0),
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            _header(),
            _subHeader(),
            Container(
              color: XMColor.bgGray,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  _grayGap(),
                  _keepVip(),
                  _grayGap(),
                  _mySportData(),
                  _grayGap(),
                  _myBodyData(),
                  _grayGap(),
                  _myList(),
                ],
              ),
            ),

          ],
        ),

      ),
    );
  }

  Widget _header() {
    Map user = meData['data']['user'];
    List headerFooters = user['userStatisticsList'];
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: XMColor.black_3),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            children: [
              SizedBox(
                width: 20,
                height: Screen.navigationBarHeight - Screen.topSafeHeight,
              ),
              const SizedBox(
                width: 25,
                height: 25,
                child: Image(
                  image: AssetImage(
                    'assets/images/me_appbar_setting.png',
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      child: const Image(
                        image: AssetImage(
                          'assets/images/me_appbar_scan.png',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 25,
                      height: 25,
                      child: const Image(
                        image: AssetImage(
                          'assets/images/me_appbar_msg.png',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                  ],
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 25),
            height: 100,
            child: Row(
              children: [
                const SizedBox(width: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: CachedNetworkImage(
                    width: 70,
                    height: 70,
                    imageUrl: user['avatar'],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      user['username'],
                      style: TextStyle(fontSize: 18, color: XMColor.vipColor),
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Image(
                          height: 20,
                          image: AssetImage('assets/images/me_header_hz.png'),
                        ),
                        SizedBox(width: 10),
                        Image(
                          height: 20,
                          image: AssetImage('assets/images/me_header_kg.png'),
                        ),
                      ],
                    ),
                  ],
                ),
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image(
                        height: 16,
                        image: AssetImage('assets/images/me_header_detail.png'),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: headerFooters.map((e) {
              return Column(
                children: [
                  Text(
                    e['count'].toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    e['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  Widget _subHeader() {
    List headEntry = meData['data']['headEntry'];
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: headEntry.map((e) {
          return Row(
            children: [
              const SizedBox(height: 60),
              Container(
                width: 23,
                height: 23,
                child: CachedNetworkImage(imageUrl: e['icon']),
              ),
              const SizedBox(width: 10),
              Text(
                e['name'],
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
  Widget _grayGap() {
    return Container(color: XMColor.bgGray, height: 10, width: Screen.width);
  }
  Widget _keepVip() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Keep 会员',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 13),
              Text(
                '完成任务，即可获得现金奖励!',
                style: TextStyle(color: XMColor.gray, fontSize: 12),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 80,
                  child: const Image(
                    image: AssetImage('assets/images/me_vip_bg.png'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _mySportData() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              const SizedBox(width: 10, height: 50),
              const Text(
                '我的运动数据',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 12,
                      child: const Image(
                          image:
                          AssetImage('assets/images/me_my_sport_data_gth.png')),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '有自动生成的数据',
                      style: TextStyle(fontSize: 12, color: XMColor.black_3),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 12,
                      child: const Image(
                        image: AssetImage('assets/images/comm_detail.png'),
                      ),
                    ),
                    const SizedBox(width: 10)
                  ],
                ),
              )
            ],
          ),

          Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text('总运动'),
                      Text(' (分钟)',
                          style: TextStyle(color: XMColor.gray, fontSize: 12))
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('494', style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 20),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text('本周消耗'),
                      Text(' (千卡)',
                          style: TextStyle(color: XMColor.gray, fontSize: 12))
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('1494', style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 20),
                ],
              )
            ],
          ),

        ],
      ),
    );

  }
  Widget _myBodyData() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              const SizedBox(width: 10, height: 50),
              const Text(
                '我的身体数据',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Container(
                width: 20,
                child: const Image(image: AssetImage('assets/images/me_my_body_data.png')),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 12,
                      child: const Image(
                        image: AssetImage('assets/images/comm_detail.png'),
                      ),
                    ),
                    const SizedBox(width: 10)
                  ],
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text(
                        '178.0',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(' 身高 cm',
                          style: TextStyle(color: XMColor.gray, fontSize: 12))
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text(
                        '66.0',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(' 体重 kg',
                          style: TextStyle(color: XMColor.gray, fontSize: 12))
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),

        ],
      ),
    );
  }
  Widget _myList() {
    List list = meData['data']['tabs'][0];
    return Column(
      children: list.map((v) {
        return InkWell(
            onTap: () {
              print(v['name']);
              //Toast.show(v['name']);
            },
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                        height: 50,
                      ),
                      Container(
                        width: 25,
                        child: CachedNetworkImage(
                          imageUrl: v['icon'],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(v['name'], style: const TextStyle(fontSize: 16)),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 12,
                              child: const Image(
                                image: AssetImage('assets/images/comm_detail.png'),
                              ),
                            ),
                            const SizedBox(width: 10)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                _grayGap(),
              ],
            ));
      }).toList(),
    );
  }
}
