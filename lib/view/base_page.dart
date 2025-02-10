import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/XMColor.dart';
import '../utils/screen.dart';
import 'app_global.dart';

class XMBasePage extends StatefulWidget {
  const XMBasePage({super.key});

  @override
  XMBasePageState createState() => XMBasePageState();
}

class XMBasePageState extends State<XMBasePage> {
  Scaffold? scaffold;
  Widget? leading;
  String title = "";
  Widget? titleWidget;
  double? titleSpace;
  List<Widget>? actions;
  Widget? body;
  bool showAppBar = false;
  List<Widget>? footerBtns;
  Widget? bottomBar;
  bool? rtabp;
  bool autoLeading = false;
  Color? scaffoldColor;
  Color? appbarColor;
  double? elevation;
  late Widget appbarBottomBar;

  @override
  Widget build(BuildContext context) {
    if (!XMAppGlobal.screenInited) {
      ScreenUtil.init(context);
      XMAppGlobal.screenInited = true;
    }

    title = title == null ? '' : title;
    showAppBar = showAppBar ?? true;
    rtabp = rtabp ?? false;
    elevation = elevation ?? 1;
    autoLeading = autoLeading ?? true;

    return Scaffold(
      backgroundColor: scaffoldColor ?? XMColor.themeColor,
      resizeToAvoidBottomInset: rtabp,
      appBar: showAppBar
          ? AppBar(
        automaticallyImplyLeading: autoLeading,
        leading: leading,
        elevation: elevation,
        centerTitle: true,
        titleSpacing: titleSpace ?? 0,
        title: titleWidget != null
            ? titleWidget
            : Text(
          title,
          style: TextStyle(fontSize: xmSp(54), color: Colors.black),
        ),
        backgroundColor: XMColor.navColor,
        actions: actions,
        //bottom: appbarBottomBar ?? null,
        bottom: null,
      )
          : null,
      persistentFooterButtons: footerBtns,
      bottomNavigationBar: null == bottomBar ? null : bottomBar,
      body: Container(
        margin: EdgeInsets.all(0),
        color: XMColor.contentColor,
        child: buildBody(),
      ),
    );
  }

  buildBody() {
    return SizedBox.shrink();
  }
}