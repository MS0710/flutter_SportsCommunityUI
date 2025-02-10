import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_store/pages/plan/plan_data.dart';

import '../../utils/XMColor.dart';
import '../../utils/screen.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  ScrollController _scrollController=  ScrollController();

  //滚动到当前日期
  _goToCurrDay(int day) {
    if (_scrollController.hasClients) {
      day = day == 1 ? 1 : day - 1;
      double x = day * (Screen.width / 7);
      _scrollController.animateTo(x,
          duration: const Duration(seconds: 2), curve: Curves.ease);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _goToCurrDay(DateTime.now().day);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: const Text(
            "智能訓練計畫",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [
            const SizedBox(width: 10),
            SizedBox(
              width: 35,
              height: 35,
              child: IconButton(
                icon: Image.asset('assets/images/sport_nav_right_wristband.png'),
                onPressed: () {
                  print("keep手環");
                  //Toast.show('keep手环');
                },
              ),
            ),
            SizedBox(
              width: 35,
              height: 35,
              child: IconButton(
                icon: Image.asset('assets/images/sport_nav_right_search.png'),
                onPressed: () {
                  print('搜索');
                },
              ),
            )
          ],
        ),

        body: ListView(
          children: [
            _suitInprogress(),
            _grayGap(),
            _trainContent(),
            _grayGap(),
          ],
        ),
      ),
    );
  }

  Widget _trainContent() {
    Map task = planData['data']['sections'][0]['suit']['days'][0];
    return Center(
      child: Container(
        width: Screen.width - 20,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      '今日訓練',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '今天是計畫的第 7 天，你的訓練任務已完成 7 / 30 天',
                      style: TextStyle(fontSize: 12, color: XMColor.lightGray),
                      textAlign: TextAlign.left,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 25),
            _teamCell(0),
            _teamCell(1),
            const SizedBox(height: 15),
            const Divider(
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task['suitTip']['subTitle'],
                      style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 120,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              image: DecorationImage(
                                  image: NetworkImage(task['suitTip']['cover']),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Text(
                              '有沒有安全又有效的減肥藥',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 25),
                            Text(
                              _getVideoTime(80),
                              style: TextStyle(
                                  fontSize: 12, color: XMColor.lightGray),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }

  Widget _teamCell(idx) {
    List task = planData['data']['sections'][0]['suit']['days'][0]['tasks'][0]
    ['todoList'];
    Map info = task[idx];
    return InkWell(
      onTap: () {
        setState(() {
          String flag = info['flag'];
          info['flag'] = flag == '1' ? '0' : '1';
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
        height: 80,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                  image: NetworkImage(info['picture']), fit: BoxFit.cover)),
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 20,
                height: 60,
              ),
              SizedBox(
                width: 20,
                height: 20,
                child: Image.asset('assets/images/sport_check_${info['flag']}.png'),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: const Color(0xffe9d399),
                        borderRadius: BorderRadius.circular(3)),
                    child: const Text(
                      '會員精選',
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
                  Text(
                    info['name'],
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    '${info['duration']}分鐘',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _suitInprogress() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffeff9f6),
                borderRadius: BorderRadius.circular(30)),
            width: Screen.width - 15 * 2,
            height: 60,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                _teamers()[0],
                _teamers()[1],
                _teamers()[2],
                Positioned(
                  left: 110,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          alignment: Alignment.bottomCenter,
                          child: const Text(
                            '我的計畫監督小組',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          height: 20,
                          child: Text(
                            '7小時前訓練',
                            style: TextStyle(
                                color: XMColor.lightGray, fontSize: 10),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  child: Image.asset(
                    'assets/images/comm_detail.png',
                    width: 8,
                    height: 15,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: Screen.width,
            height: 80,
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: _dateView(),
            ),
          )


        ],
      ),
    );
  }
  String _getVideoTime(seconds) {
    seconds = 80.0;
    int min = seconds ~/ 60;
    double sec = seconds % 60;
    int s = sec.toInt();
    return '$min:$s';
  }
  _dateView() {
    DateTime currDt = DateTime.now();
    int days = _getDaysNum(currDt.year, currDt.month);
    List<Widget> dayItems = [];
    double itemWidth = Screen.width / 7;
    for (var i = 1; i <= days; i++) {
      DateTime dt = DateTime(currDt.year, currDt.month, i);
      //String weekday = DateUtil.getWeekday(dt);
      String weekday = getWeekDayToCH(dt.weekday);
      Widget item = SizedBox(
        width: itemWidth,
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
              alignment: Alignment.center,
              child: Text(
                //weekday.substring(2),
                //"一",
                weekday,
                style: TextStyle(
                    fontSize: 14,
                    color: currDt.day == i ? Colors.black : XMColor.lightGray),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 40,
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: currDt.day == i ? const Color(0xff554f5e) : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  child: Text(
                    i.toString(),
                    style: TextStyle(
                        color: currDt.day == i ? Colors.white : Colors.black,
                        fontSize: 10),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            )
          ],
        ),
      );
      dayItems.add(item);
    }
    return dayItems;

  }
  //將星期幾轉中文
  String getWeekDayToCH(int day){
    switch(day){
      case 1:
        return "一";
      case 2:
        return "二";
      case 3:
        return "三";
      case 4:
        return "四";
      case 5:
        return "五";
      case 6:
        return "六";
      case 7:
        return "日";
      default:
        return "";
    }
  }
  /*根據年分月份獲取當前月有多少天*/
  int _getDaysNum(int y, int m) {
    if (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
      return 31;
    } else if (m == 2) {
      if (((y % 4 == 0) && (y % 100 != 0)) || (y % 400 == 0)) {
        //閏年 2月29
        return 29;
      } else {
        //平年 2月28
        return 28;
      }
    } else {
      return 30;
    }
  }
  _teamers() {
    List teams = [
      "http://static1.keepcdn.com/avatar/2019/07/11/20/13/367bafc8b2e7bd975d2723caa467ce73a368e512.jpg",
      "http://static1.keepcdn.com/avatar/2019/05/14/16/3d8e39f826f4a54f753b5613987dfbfcf55ef623.jpg",
      "http://static1.keepcdn.com/avatar/2019/06/25/20/599b7559d3bf7ee628a0730c9ed3e4e10553c25d.jpg"
    ];
    return teams.map((v) {
      double w = 35;
      int idx = teams.indexOf(v);
      double x = (w - 10) * (2 - idx.toDouble()) + 10;
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
            backgroundImage: NetworkImage(v),
            radius: 20,
          ),
        ),
      );
    }).toList();
  }
  Widget _grayGap() {
    return Container(
      height: 11,
      color: XMColor.bgGray,
    );
  }
}
