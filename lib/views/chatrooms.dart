import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/chat/chat.dart';
import 'package:testlogin/helper/authenticate.dart';
import 'package:testlogin/helper/constants.dart';
import 'package:testlogin/helper/helperfunctions.dart';
import 'package:testlogin/helper/theme.dart';
import 'package:testlogin/services/auth.dart';
import 'package:testlogin/services/database.dart';
import 'package:testlogin/views/search.dart';
import 'package:testlogin/views/searchJasa.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ChatRoomsTile(
                userName: snapshot.data.documents[index].data()['chatRoomId']
                    .toString()
                    .replaceAll("_", "")
                    .replaceAll(Constants.myName, ""),
                chatRoomId: snapshot.data.documents[index].data()["chatRoomId"],
              );
            })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: Text(
          'Chat Room',
        ),
        elevation: 0.0,
        centerTitle: false,
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       AuthService().signOut();
        //       Navigator.pushReplacement(context,
        //           MaterialPageRoute(builder: (context) => Authenticate()));
        //     },
        //     child: Container(
        //         padding: EdgeInsets.symmetric(horizontal: 16),
        //         child: Icon(Icons.exit_to_app)),
        //   )
        // ],
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.search),
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => SearchJasa()));
      //   },
      // ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Chat(
              chatRoomId: chatRoomId,
            )
        ));
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: CustomTheme.colorAccent,
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(userName.substring(0, 1),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300)),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}