///******************************************************************
///Copyright 2019 The Lmy Authors. All rights reserved.
/// *****************************************************************
library smart_color;

import 'dart:ui';
import 'dart:core';
import 'package:flutter/painting.dart';
import 'package:pigment/pigment.dart';
import 'package:flutter/material.dart';

///依赖于pigment插件
export 'package:pigment/pigment.dart' show CSSColor;

/// 智能的颜色类
class SmartColor {
  ///颜色解析
  static Color parse(String color) => _getColor(color);

  ///解析cssColor
  static Color parseCssColor(CSSColor color) => Pigment.fromCSSColor(color);

  /// 用以判断是否适合蚂蚁金服颜色设计
  /// 建议颜色的亮度大于70，颜色的饱和度大于70
  static bool suitAntDesign(Color color){
    HSLColor hslColor = HSLColor.fromColor(color);
    // flutter 中的饱和度和亮度为0到1范围
    return hslColor.lightness*100 >= 70 && hslColor.saturation*100 >=70;
  }

  /// 得到蚂蚁金服颜色
  /// 通过一个基本色，获取十种不同的颜色
  static AntDesignColor antDColor(Color color) {
    Map<int, Color> colors = Map<int, Color>();
    for (int i = 1; i <= 10; i++) {
      colors[i] = SmartColor._makeAntDColor(color, i);
    }
    return AntDesignColor(color.value, colors);
  }

  ///制作蚂蚁金服颜色
  ///color: 基本颜色
  ///index：主色色号 范围为[1,10]
  static Color _makeAntDColor(Color color, int index) {
    bool isLight = index <= 6;
    HSVColor hsv = HSVColor.fromColor(color);
    int lightColorCount = 5;
    var i = isLight ? lightColorCount + 1 - index : index - lightColorCount - 1;
    return HSVColor.fromAHSV(
      1,
      _getHue(hsv, i, isLight),
      _getSaturation(hsv, i, isLight),
      _getValue(hsv, i, isLight),
    ).toColor();
  }

  ///将字符串转换为颜色
  ///使用Pigment插件
  static _getColor(String color) {
    Color rgbaColor = _getRGBAColorFromString(color);
    if (rgbaColor != null) {
      return rgbaColor;
    }
    return Pigment.fromString(color);
  }

  /// RGBA字符串转换为颜色
  static Color _getRGBAColorFromString(String string) {
    string = string.replaceAll(" ", ""); // pseudo-trimming
    if (string.startsWith("rgba(") && string.endsWith(")")) {
      // Correct
      string = string.replaceAll("rgba(", "");
      string = string.replaceAll(")", "");
      List<String> rgba = string.split(",");
      if (rgba.length == 4) {
        int r = int.parse(rgba[0]);
        int g = int.parse(rgba[1]);
        int b = int.parse(rgba[2]);
        double a = double.parse(rgba[3]) * 255;
        return new Color.fromARGB(a.toInt(), r, g, b);
      }
      return null;
    }
    return null;
  }

  /// 以下为蚂蚁金服设计颜色

  ///  Dust Red / 薄暮
  /// 斗志、奔放
  ///
  static AntDesignColor red = SmartColor.antDColor(Color(0xFFf5222d));

  ///Volcano / 火山
  ///醒目、澎湃
  static AntDesignColor volcano = SmartColor.antDColor(Color(0xFFfa541c));

  /// Sunset Orange / 日暮
  /// 温暖、欢快
  static AntDesignColor orange = SmartColor.antDColor(Color(0xFFfa8c16));

  ///Calendula Gold / 金盏花
  ///活力、积极
  static AntDesignColor gold = SmartColor.antDColor(Color(0xFFfaad14));

  ///Sunrise Yellow / 日出
  ///出生、阳光
  static AntDesignColor yellow = SmartColor.antDColor(Color(0xFFfadb14));

  ///Lime / 青柠
  ///自然、生机
  static AntDesignColor lime = SmartColor.antDColor( Color(0xffa0d911));

  ///Polar Green / 极光绿
  ///健康、创新
  static AntDesignColor green = SmartColor.antDColor(Color(0xff52c41a));

  /// Cyan / 明青
  /// 希望、坚强
  static AntDesignColor cyan = SmartColor.antDColor(Color(0xff13c2c2));

  ///Daybreak static Color blue / 拂晓蓝
  /// 包容、科技、普惠
  static AntDesignColor blue = SmartColor.antDColor(Color(0xff1890ff));

  /// Geek static Color blue / 极客蓝
  /// 探索、钻研
  static AntDesignColor geekBlue = SmartColor.antDColor(Color(0xff2f54eb));

  ///Golden static Color purple / 酱紫
  ///优雅、浪漫
  static AntDesignColor purple = SmartColor.antDColor(Color(0xff722ed1));

  ///static Color magenta / 法式洋红
  ///明快、感性
  static AntDesignColor magenta = SmartColor.antDColor(Color(0xffeb2f96));

  ///static Color grey
  static AntDesignColor grey = SmartColor.antDColor(Color(0xffbfbfbf));
}

/// 定义蚂蚁金服色彩类
class AntDesignColor extends ColorSwatch<int> {
  const AntDesignColor(int primary, Map<int, Color> swatch)
      : super(primary, swatch);
  Color get shade1 => this[1];
  Color get shade2 => this[2];
  Color get shade3 => this[3];
  Color get shade4 => this[4];
  Color get shade5 => this[5];
  Color get shade6 => this[6];
  Color get shade7 => this[7];
  Color get shade8 => this[8];
  Color get shade9 => this[9];
  Color get shade10 => this[10];
}

///getHue 获取色相渐变
double _getHue(HSVColor hsv, int i, bool isLight) {
  double hue;
  int hueStep = 2;
  if (hsv.hue >= 60 && hsv.hue <= 240) {
    hue = isLight == true ? hsv.hue - hueStep * i : hsv.hue + hueStep * i;
  } else {
    hue = isLight == true ? hsv.hue + hueStep * i : hsv.hue - hueStep * i;
  }
  if (hue < 0) {
    hue += 360;
  } else if (hue >= 360) {
    hue -= 360;
  }
  return hue.round().toDouble();
}

///getSaturation 获取饱和度渐变
double _getSaturation(HSVColor hsv, int i, bool isLight) {
  int saturation;
  int saturationStep = 16;
  int saturationStep2 = 5;
  int darkColorCount = 4;
  var lightColorCount = 5;
  if (isLight == true) {
    saturation = (hsv.saturation * 100).round() - saturationStep * i;
  } else if (i == darkColorCount) {
    saturation = (hsv.saturation * 100).round() + saturationStep;
  } else {
    saturation = (hsv.saturation * 100).round() + saturationStep2 * i;
  }
  if (saturation > 100) {
    saturation = 100;
  }
  if (isLight == true && i == lightColorCount && saturation > 10) {
    saturation = 10;
  }
  if (saturation < 6) {
    saturation = 6;
  }
  return saturation.toDouble() / 100;
}

/// getValue 获取明度渐变
double _getValue(HSVColor hsv, int i, bool isLight) {
  int brightnessStep1 = 5;
  int brightnessStep2 = 15;
  if (isLight == true) {
    return (((hsv.value * 100).round() + brightnessStep1 * i) > 100
                ? 100
                : ((hsv.value * 100).round() + brightnessStep1 * i))
            .toDouble() /
        100;
  }
  return ((hsv.value * 100).round() - brightnessStep2 * i).toDouble() / 100;
}
