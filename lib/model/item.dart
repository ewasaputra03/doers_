// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:testlogin/views/detailNotif.dart';
//
// final Map<String, Item> _items = <String, Item>{};
// Item _itemForMessage(Map<String, dynamic> message) {
//   final dynamic data = message['data'] ?? message;
//   final String itemId = data['id'];
//   final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
//     ..status = data['status'];
//   return item;
// }
//
// class Item {
//   Item({this.itemId});
//   final String itemId;
//
//   StreamController<Item> _controller = StreamController<Item>.broadcast();
//   Stream<Item> get onChanged => _controller.stream;
//
//   String _status;
//   String get status => _status;
//   set status(String value) {
//     _status = value;
//     _controller.add(this);
//   }
//
//   static final Map<String, Route<void>> routes = <String, Route<void>>{};
//   Route<void> get route {
//     final String routeName = '/detail/$itemId';
//     return routes.putIfAbsent(
//       routeName,
//           () => MaterialPageRoute<void>(
//         settings: RouteSettings(name: routeName),
//         builder: (BuildContext context) => DetailNotif(itemId),
//       ),
//     );
//   }
// }