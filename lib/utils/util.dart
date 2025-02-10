import 'package:flutter/services.dart';
import 'package:flutter_store/utils/toast.dart';

commingSoon() {
  Toast.show('Coming soon');
}

xmKeyboradHide() {
  print('xmKeyboradHide');
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

String imgPath(String imgName) {
  return 'assets/images/$imgName.png';
}