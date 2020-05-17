// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  // Text Styles
  static const TextStyle buttonTitleStyle = TextStyle(
      color: baseTextColor, fontSize: 18, fontWeight: FontWeight.normal);

  static const TextStyle detailTextStyle = TextStyle(
      color: baseTextColor, fontSize: 18, fontWeight: FontWeight.normal);

  static const TextStyle headerTextStyle = TextStyle(
      color: baseTextColor, fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle subtitleTextStyle = TextStyle(
      color: subtitleTextColor, fontSize: 14, fontWeight: FontWeight.normal);

  static const TextStyle actionTextStyle = TextStyle(
      color: subtitleTextColor, fontSize: 14, fontWeight: FontWeight.bold);

  static const TextStyle placeholderTextStyle = TextStyle(
      color: placeholderTextColor, fontSize: 14, fontWeight: FontWeight.normal);

  static const TextStyle textInputStyle = TextStyle(
      color: baseTextColor, fontSize: 16, fontWeight: FontWeight.normal);

  // Base Colors
  static const Color baseBGColor = Color(0xFF374B4A);

  static const Color baseTextColor = Color(0xFFF0F7F4);

  static const Color subtitleTextColor = Color(0xFFD7D7D7);

  // Button Colors
  static const Color buttonBG = Color(0xFF000000);

  static const Color buttonEnabledOutlineColor = Color(0xFF99E1D9);

  static const Color buttonHighlightedOutlineColor = Color(0xFFF0F7F4);

  static const Color placeholderTextColor = Color(0xFFD7D7D7);

  // Input Colors
  static const Color inputBorderColor = Color(0xFF99E1D9);
}
