// import 'package:flutter/material.dart';
//
// class DetailNotif extends StatefulWidget {
//   DetailNotif(this.itemId);
//   final String itemId;
// }
//   @override
//   _DetailNotifState createState() => _DetailNotifState();
// }
//
// class _DetailNotifState extends State<DetailNotif> {
//   Item _item;
//   StreamSubscription<Item> _subscription;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _item = _items[widget.itemId];
//     _subscription = _item.onChanged.listen((Item item) {
//       if (!mounted) {
//         _subscription.cancel();
//       } else {
//         setState(() {
//           _item = item;
//         });
//       }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//     );
//   }
// }
