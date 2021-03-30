import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenApdar {
  static init(context) {
    ScreenUtil.init(
      // 设备像素大小(必须在首页中获取)
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      Orientation.landscape,
      // 设计尺寸
      // designSize: Size(750, 1334),
      // allowFontScaling: false,
    );
  }

  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  static setWidth(double width) {
    return ScreenUtil().setWidth(width);
  }

  static setHeight(double height) {
    return ScreenUtil().setHeight(height);
  }

  static setFontSize(double fontSize) {
    return ScreenUtil().setSp(fontSize);
  }
}
