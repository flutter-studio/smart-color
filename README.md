
English | [简体中文](./README_zh-CN.md)

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
SmartColor.antDColor(Color(0xFFf5222d)); //To get the color of ant design, you can get ten different colors from one base color
SmartColor.antDColor(Color(0xFFf5222d)).shade1; //Gets color 1
SmartColor.antDColor(Color(0xFFf5222d)).shade2; //Gets color 2
SmartColor.antDColor(Color(0xFFf5222d)).shade3; //Gets color 3
...
SmartColor.antDColor(Color(0xFFf5222d)).shade6; //Gets color 6, which is the same as the base color

...
//Some common colors are already defined in the library
SmartColor.red;
SmartColor.red.shade1;
SmartColor.green;
SmartColor.green.shade1;

```
