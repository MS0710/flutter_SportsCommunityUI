import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/XMColor.dart';
import '../utils/screen.dart';

class TileCard extends StatelessWidget {
  final String img;
  final String content;
  final String avatar;
  final String name;
  final String likes;
  final bool isVip;

  TileCard({
    super.key,
    required this.img,
    required this.content,
    required this.avatar,
    required this.name,
    required this.likes,
    this.isVip = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3),
                topRight: Radius.circular(3),
              ),
              child: CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.cover,
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: xmDp(10)),
              margin: EdgeInsets.only(top: xmDp(5)),
              child: Text(
                content,
                style: TextStyle(
                  color: const Color(0xff343434),
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: xmDp(5),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      /*Container(
                        width: xmDp(18),
                        height: xmDp(10),
                        color: Colors.red,
                      ),*/
                      Positioned(
                        child: Container(
                          width: 20,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(avatar),
                            radius: xmDp(30),
                          ),
                        ),
                      ),

                      isVip
                          ? Positioned(
                        width: xmDp(30),
                        height: xmDp(30),
                        bottom: 0,
                        right: 0,
                        child: const CircleAvatar(backgroundColor: Colors.white,),
                      )
                          : const Text(""),
                      isVip ? Positioned(
                        width: xmDp(28),
                        height: xmDp(28),
                        bottom: xmDp(1),
                        right: xmDp(1),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage("assets/images/vip.png"),
                        ),
                      )
                          : const Text(""),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(left: xmDp(10)),
                    //width: xmDp(180),
                    width: MediaQuery.of(context).size.width/5,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: const Color(0xff343434),
                        fontSize: ScreenUtil().setSp(11),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: xmDp(10)),
                          width: xmDp(10),
                          height: xmDp(10),
                          child: Image.asset('assets/images/like.png'),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: xmDp(10)),
                          child: Text(
                            likes,
                            style: TextStyle(
                              color: XMColor.kgray,
                              fontSize: ScreenUtil().setSp(11),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
