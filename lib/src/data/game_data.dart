import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
enum Level { Hard, Medium, Easy }

List<String> fillSourceArray() {
  return [
    "Bánh mì","Bread","Xin Chào","Hello", "Tạm Biệt","Goodbye", "Màu đỏ","Red", "Màu vàng","Yellow", "Trái tim","Heart"
  ];
}

List getSourceArray(
    Level level,
    ) {
  List<String> levelAndKindList = new List<String>();
  List sourceArray = fillSourceArray();
  if (level == Level.Hard) {
    sourceArray.forEach((element) {
      levelAndKindList.add(element);
    });
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  }

  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<bool> getInitialItemState(Level level) {
  List<bool> initialItemState = new List<bool>();
  if (level == Level.Hard) {
    for (int i = 0; i < 12; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 8; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 4; i++) {
      initialItemState.add(true);
    }
  }
  return initialItemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level level) {
  List<GlobalKey<FlipCardState>> cardStateKeys =
  new List<GlobalKey<FlipCardState>>();
  if (level == Level.Hard) {
    for (int i = 0; i < 12; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 8; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 4; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  return cardStateKeys;
}