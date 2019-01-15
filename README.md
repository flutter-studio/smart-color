# smart_color

[![pub package](https://img.shields.io/pub/v/smart_color.svg)](https://pub.dartlang.org/packages/smart_color)

A smart color  package, All [ant design colors](https://ant.design/docs/spec/colors-cn) are included in the plugin

## Usage
To use this plugin, add `smart_color` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Example

``` dart
// Import package
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';

SmartColor.parse("#ffffff");
SmartColor.parse("white");
SmartColor.parse("rgb(0,0,0)")
SmartColor.parse("rgba(0,0,0,.5)")
SmartColor.antDColor(Color(0xFFf5222d)); //得到蚂蚁金服颜色，通过一个基色可以得到十种不同的颜色
SmartColor.antDColor(Color(0xFFf5222d)).shade1; //获取1色色号颜色值
SmartColor.antDColor(Color(0xFFf5222d)).shade2; //获取2色色号颜色值
SmartColor.antDColor(Color(0xFFf5222d)).shade3; //获取3色色号颜色值
...
SmartColor.antDColor(Color(0xFFf5222d)).shade6; //6色色号颜色值和主色值一样，即和SmartColor.antDColor(Color(0xFFf5222d))颜色一样

...
//一些常用的颜色已经在库中进行定义了
SmartColor.red;
SmartColor.red.shade1;
SmartColor.green;
SmartColor.green.shade1;

```
