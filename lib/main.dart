import 'package:flutter/material.dart';

void main() => runApp(SRVoiceV4());

class SRVoiceV4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF12001E)),
      home: SRV4Room(),
    );
  }
}

class SRV4Room extends StatefulWidget {
  @override
  _SRV4RoomState createState() => _SRV4RoomState();
}

class _SRV4RoomState extends State<SRV4Room> {
  String roomName = "SR Voice Party 🎙️";
  String announcement = "Welcome to SR Voice - no body come to my room";
  String roomLabel = "Friends";
  List<bool> seats = List.generate(10, (_) => false);
  bool isLocked = false;
  List<String> chats = ["Hi", "Welcome"];
  TextEditingController chatCtrl = TextEditingController();
  String searchQuery = "";
  double walletBalance = 1250.0;
  String inviteCode = "SR-APON-786";
  double inviteIncome = 345.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A0033),
      appBar: AppBar(
        backgroundColor: Color(0xFF4A148C),
        title: Row(children: [
          Container(padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Color(0xFFFFD700), borderRadius: BorderRadius.circular(8)), child: Text("SR", style: TextStyle(color: Color(0xFF4A148C), fontWeight: FontWeight.bold))),
          SizedBox(width: 8),
          Expanded(child: Text(roomName, style: TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis)),
        ]),
        actions: [
          Icon(Icons.search, color: Color(0xFFFFD700)),
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (c) => [
              PopupMenuItem(child: Text(isLocked ? "Unlock Room" : "Lock Room"), value: "lock"),
              PopupMenuItem(child: Text("Room Set"), value: "roomset"),
              PopupMenuItem(child: Text("Clear Chat"), value: "clear"),
              PopupMenuItem(child: Text("Clear Charm"), value: "clearcharm"),
            ],
            onSelected: (v){
              if(v=="lock") setState(()=> isLocked=!isLocked);
              if(v=="roomset") openRoomSet();
              if(v=="clear") setState(()=> chats.clear());
            },
          )
        ],
      ),
      body: Column(
        children: [
          // ID / Room Search + Theme
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.black26,
            child: Row(
              children: [
                Expanded(child: TextField(decoration: InputDecoration(hintText: "ID / Room Search", hintStyle: TextStyle(color: Colors.white38, fontSize: 12), prefixIcon: Icon(Icons.search, size: 18, color: Color(0xFFFFD700)), filled: true, fillColor: Color(0xFF2A0050), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none), contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10)), style: TextStyle(color: Colors.white, fontSize: 12), onChanged: (v)=> setState(()=> searchQuery=v))),
                SizedBox(width: 8),
                Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Color(0xFF4A148C), borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFFFD700))), child: Text(roomLabel, style: TextStyle(color: Color(0xFFFFD700), fontSize: 10))),
                SizedBox(width: 6),
                Text("ID: 123456", style: TextStyle(color: Colors.white54, fontSize: 10)),
              ],
            ),
          ),
          // Announcement + Chat Bubbles
          Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: chats.length,
              itemBuilder: (c,i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Color(0xFF4A148C).withOpacity(0.8), borderRadius: BorderRadius.circular(16)), child: Text(chats[i], style: TextStyle(color: Colors.white, fontSize: 12))),
            ),
          ),
          // 10 Seats 5+5
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF2A0050), Color(0xFF12001E)]),
                image: DecorationImage(image: NetworkImage("https://i.ibb.co/3YQ8XzM/mosque-silhouette.png"), opacity: 0.05, fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(5, (i) => seatCircle(i))),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(5, (i) => seatCircle(i+5))),
                  SizedBox(height: 12),
                  Text(announcement, style: TextStyle(color: Colors.white38, fontSize: 10), textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
          // Bottom Bar
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Color(0xFF2A0050), borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: TextField(controller: chatCtrl, decoration: InputDecoration(hintText: "Say Hi...", hintStyle: TextStyle(color: Colors.white38, fontSize: 12), filled: true, fillColor: Colors.black26, border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none), contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8)), style: TextStyle(color: Colors.white, fontSize: 12))),
                    IconButton(icon: Icon(Icons.send, color: Color(0xFFFFD700)), onPressed: (){ if(chatCtrl.text.isNotEmpty){ setState(()=> chats.add(chatCtrl.text)); chatCtrl.clear(); } }),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    bottomItem(Icons.mic, "Mic", (){ setState(()=> seats[0]=!seats[0]); }),
                    bottomItem(Icons.emoji_emotions, "Emoji", (){}),
                    bottomItem(Icons.card_giftcard, "Gift", (){}),
                    bottomItem(Icons.videogame_asset, "Game", (){}),
                    bottomItem(Icons.wallet, "Wallet", openWallet),
                    bottomItem(Icons.share, "Invite", openInvite),
                    bottomItem(Icons.exit_to_app, "Exit", (){}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget seatCircle(int i){
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(()=> seats[i]=!seats[i]),
          child: Container(
            width: 52, height: 52,
            decoration: BoxDecoration(shape: BoxShape.circle, color: seats[i] ? Color(0xFF4A148C) : Color(0xFF1E1E1E), border: Border.all(color: seats[i] ? Color(0xFFFFD700) : Colors.white24, width: 2)),
            child: Icon(seats[i] ? Icons.mic : Icons.person, color: seats[i] ? Color(0xFFFFD700) : Colors.white30, size: 24),
          ),
        ),
        SizedBox(height: 3),
        Text("Seat ${i+1}", style: TextStyle(fontSize: 9, color: seats[i] ? Color(0xFFFFD700) : Colors.white54)),
      ],
    );
  }

  Widget bottomItem(IconData icon, String label, Function onTap){
    return InkWell(
      onTap: ()=> onTap(),
      child: Column(children: [Icon(icon, color: Colors.white70, size: 20), SizedBox(height: 2), Text(label, style: TextStyle(fontSize: 8, color: Colors.white54))]),
    );
  }

  void openWallet(){
    showModalBottomSheet(context: context, backgroundColor: Color(0xFF1A0033), builder: (_)=> Container(padding: EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text("💰 Wallet", style: TextStyle(color: Color(0xFFFFD700), fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 12),
      Text("Balance: \$${walletBalance}", style: TextStyle(color: Colors.white, fontSize: 16)),
      SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text("100K=\$0.99", style: TextStyle(color: Colors.white54, fontSize: 10)), Text("1M=\$9.99", style: TextStyle(color: Colors.white54, fontSize: 10)), Text("10M=\$99.99", style: TextStyle(color: Colors.white54, fontSize: 10))]),
    ])));
  }

  void openInvite(){
    showModalBottomSheet(context: context, backgroundColor: Color(0xFF1A0033), builder: (_)=> Container(padding: EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("🎁 Invite System", style: TextStyle(color: Color(0xFFFFD700), fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      Text("My Income: \$${inviteIncome}", style: TextStyle(color: Colors.greenAccent)),
      SizedBox(height: 8),
      Text("My Code: $inviteCode", style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
      SizedBox(height: 12),
      ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.share), label: Text("Share & Invite Friends"), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF4A148C))),
    ])));
  }

  void openRoomSet(){
    TextEditingController n = TextEditingController(text: roomName);
    TextEditingController a = TextEditingController(text: announcement);
    TextEditingController l = TextEditingController(text: roomLabel);
    showDialog(context: context, builder: (_)=> AlertDialog(
      backgroundColor: Color(0xFF2A0050),
      title: Text("Room Set", style: TextStyle(color: Color(0xFFFFD700))),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: n, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "Room Name", labelStyle: TextStyle(color: Colors.white54))),
        TextField(controller: a, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "Announcement", labelStyle: TextStyle(color: Colors.white54))),
        TextField(controller: l, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "Label (Friends/Game/Music/Chat)", labelStyle: TextStyle(color: Colors.white54))),
      ]),
      actions: [TextButton(onPressed: ()=> Navigator.pop(context), child: Text("Cancel")), ElevatedButton(onPressed: (){ setState(()=> {roomName=n.text, announcement=a.text, roomLabel=l.text}); Navigator.pop(context); }, child: Text("Save"), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFD700), foregroundColor: Color(0xFF4A148C)))],
    ));
  }
}
