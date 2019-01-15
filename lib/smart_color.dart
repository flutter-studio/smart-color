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
  static Color red1 = Color(0xFFFFF1F0);
  static Color red2 = Color(0xFFFFCCC7);
  static Color red3 = Color(0xFFffa39e);
  static Color red4 = Color(0xFFff7875);
  static Color red5 = Color(0xFFff4d4f);
  static Color red6 = Color(0xFFf5222d);
  static Color red7 = Color(0xFFcf1322);
  static Color red8 = Color(0xFFa8071a);
  static Color red9 = Color(0xFF820014);
  static Color red10 = Color(0xFF5c0011);

  ///Volcano / 火山
  ///醒目、澎湃
  static Color volcano1 = Color(0xFFfff2e8);
  static Color volcano2 = Color(0xFFffd8bf);
  static Color volcano3 = Color(0xFFffbb96);
  static Color volcano4 = Color(0xFFff9c6e);
  static Color volcano5 = Color(0xFFff7a45);
  static Color volcano6 = Color(0xFFfa541c);
  static Color volcano7 = Color(0xFFd4380d);
  static Color volcano8 = Color(0xFFad2102);
  static Color volcano9 = Color(0xFF871400);
  static Color volcano10 = Color(0xFF610b00);

  /// Sunset Orange / 日暮
  /// 温暖、欢快
  static Color orange1 = Color(0xFFfff7e6);
  static Color orange2 = Color(0xFFffe7ba);
  static Color orange3 = Color(0xFFffd591);
  static Color orange4 = Color(0xFFffc069);
  static Color orange5 = Color(0xFFffa940);
  static Color orange6 = Color(0xFFfa8c16);
  static Color orange7 = Color(0xFFd46b08);
  static Color orange8 = Color(0xFFad4e00);
  static Color orange9 = Color(0xFF873800);
  static Color orange10 = Color(0xFF61250);

  ///Calendula Gold / 金盏花
  ///活力、积极
  static Color gold1 = Color(0xFFfffbe6);
  static Color gold2 = Color(0xFFfff1b8);
  static Color gold3 = Color(0xFFffe58f);
  static Color gold4 = Color(0xFFffd666);
  static Color gold5 = Color(0xFFffc53d);
  static Color gold6 = Color(0xFFfaad14);
  static Color gold7 = Color(0xFFd48806);
  static Color gold8 = Color(0xFFad6800);
  static Color gold9 = Color(0xFF874d00);
  static Color gold10 = Color(0xFF613400);

  ///Sunrise Yellow / 日出
  ///出生、阳光
  static Color yellow1 = Color(0xFFfeffe6);
  static Color yellow2 = Color(0xFFffffb8);
  static Color yellow3 = Color(0xFFfffb8f);
  static Color yellow4 = Color(0xFFfff566);
  static Color yellow5 = Color(0xFFffec3d);
  static Color yellow6 = Color(0xFFfadb14);
  static Color yellow7 = Color(0xFFd4b106);
  static Color yellow8 = Color(0xFFad8b00);
  static Color yellow9 = Color(0xFF876800);
  static Color yellow10 = Color(0xFF61470);

  ///Lime / 青柠
  ///自然、生机
  static Color lime1 = Color(0xfffcffe6);
  static Color lime2 = Color(0xfff4ffb8);
  static Color lime3 = Color(0xffeaff8f);
  static Color lime4 = Color(0xffd3f261);
  static Color lime5 = Color(0xffbae637);
  static Color lime6 = Color(0xffa0d911);
  static Color lime7 = Color(0xff7cb305);
  static Color lime8 = Color(0xff5b8c00);
  static Color lime9 = Color(0xff3f6600);
  static Color lime10 = Color(0xff254000);

  ///Polar Green / 极光绿
  ///健康、创新
  static Color green1 = Color(0xfff6ffed);
  static Color green2 = Color(0xffd9f7be);
  static Color green3 = Color(0xffb7eb8f);
  static Color green4 = Color(0xff95de64);
  static Color green5 = Color(0xff73d13d);
  static Color green6 = Color(0xff52c41a);
  static Color green7 = Color(0xff389e0d);
  static Color green8 = Color(0xff237804);
  static Color green9 = Color(0xff135200);
  static Color green10 = Color(0xff092b0);

  /// Cyan / 明青
  /// 希望、坚强
  static Color cyan1 = Color(0xffe6fffb);
  static Color cyan2 = Color(0xffb5f5ec);
  static Color cyan3 = Color(0xff87e8de);
  static Color cyan4 = Color(0xff5cdbd3);
  static Color cyan5 = Color(0xff36cfc9);
  static Color cyan6 = Color(0xff13c2c2);
  static Color cyan7 = Color(0xff08979c);
  static Color cyan8 = Color(0xff006d75);
  static Color cyan9 = Color(0xff00474f);
  static Color cyan10 = Color(0xff0023);

  ///Daybreak static Color blue / 拂晓蓝
  /// 包容、科技、普惠
  static Color blue1 = Color(0xffe6f7ff);
  static Color blue2 = Color(0xffbae7ff);
  static Color blue3 = Color(0xff91d5ff);
  static Color blue4 = Color(0xff69c0ff);
  static Color blue5 = Color(0xff40a9ff);
  static Color blue6 = Color(0xff1890ff);
  static Color blue7 = Color(0xff096dd9);
  static Color blue8 = Color(0xff0050b3);
  static Color blue9 = Color(0xff003a8c);
  static Color blue10 = Color(0xff002766);

  /// Geek static Color blue / 极客蓝
  /// 探索、钻研
  static Color geekBlue1 = Color(0xfff0f5ff);
  static Color geekBlue2 = Color(0xffd6e4ff);
  static Color geekBlue3 = Color(0xffadc6ff);
  static Color geekBlue4 = Color(0xff85a5ff);
  static Color geekBlue5 = Color(0xff597ef7);
  static Color geekBlue6 = Color(0xff2f54eb);
  static Color geekBlue7 = Color(0xff1d39c4);
  static Color geekBlue8 = Color(0xff10239e);
  static Color geekBlue9 = Color(0xff061178);
  static Color geekBlue10 = Color(0xff030852);

  ///Golden static Color purple / 酱紫
  ///优雅、浪漫
  static Color purple1 = Color(0xfff9f0ff);
  static Color purple2 = Color(0xffefdbff);
  static Color purple3 = Color(0xffd3adf7);
  static Color purple4 = Color(0xffb37feb);
  static Color purple5 = Color(0xff9254de);
  static Color purple6 = Color(0xff722ed1);
  static Color purple7 = Color(0xff531dab);
  static Color purple8 = Color(0xff391085);
  static Color purple9 = Color(0xff22075e);
  static Color purple10 = Color(0xff120338);

  ///static Color magenta / 法式洋红
  ///明快、感性
  static Color magenta1 = Color(0xfffff0f6);
  static Color magenta2 = Color(0xffffd6e7);
  static Color magenta3 = Color(0xffffadd2);
  static Color magenta4 = Color(0xffff85c0);
  static Color magenta5 = Color(0xfff759ab);
  static Color magenta6 = Color(0xffeb2f96);
  static Color magenta7 = Color(0xffc41d7f);
  static Color magenta8 = Color(0xff9e1068);
  static Color magenta9 = Color(0xff780650);
  static Color magenta10 = Color(0xff520339);

  ///static Color grey
  static Color grey1 = Color(0xffffffff);
  static Color grey2 = Color(0xfffafafa);
  static Color grey3 = Color(0xfff5f5f5);
  static Color grey4 = Color(0xffe8e8e8);
  static Color grey5 = Color(0xffd9d9d9);
  static Color grey6 = Color(0xffbfbfbf);
  static Color grey7 = Color(0xff8c8c8c);
  static Color grey8 = Color(0xff595959);
  static Color grey9 = Color(0xff262626);
  static Color grey10 = Color(0xff000000);
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
