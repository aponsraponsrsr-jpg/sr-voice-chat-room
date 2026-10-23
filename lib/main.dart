import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(SRVoiceV4());

class SRVoiceV4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SR Voice Chat',
      theme: ThemeData(
        primaryColor: Color(0xFF4A148C),
        scaffoldBackgroundColor: Color(0xFF1A0B2E),
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A0B2E),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120, height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF4A148C), Color(0xFFFFD700)]),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.mic, size: 60, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text('SR VOICE', style: TextStyle(color: Color(0xFFFFD700), fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2)),
              Text('CHAT ROOM V4', style: TextStyle(color: Colors.white70, fontSize: 14)),
              SizedBox(height: 40),
              TextField(
                controller: emailCtrl,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter Gmail (Owner: aponsraponsrsr@gmail.com)',
                  hintStyle: TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Color(0xFF2D1B4E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD700),
                  foregroundColor: Color(0xFF4A148C),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if(emailCtrl.text.isEmpty) return;
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage(email: emailCtrl.text.trim())));
                },
                child: Text('ENTER ROOM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String email;
  HomePage({required this.email});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool get isOwner => widget.email == 'aponsraponsrsr@gmail.com';
  int ownerCoins = 1000000;
  int userCoins = 5000;
  String groupName = 'SR Voice Chat Room';
  String announcement = 'Welcome to SR Voice - No body come to my room';
  String groupLabel = 'Friends';
  List<String> seats = List.generate(10, (i) => i==0 ? 'Owner' : 'Empty');

  String inviteCode = 'SR${Random().nextInt(9000)+1000}';
  int myIncome = 0;

  void showProfile(int index) {
    bool isOwnerSeat = index==0;
    int coins = isOwnerSeat ? ownerCoins : userCoins;
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF2D1B4E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 40, backgroundColor: Color(0xFFFFD700), child: Icon(Icons.person, size: 40, color: Color(0xFF4A148C))),
            SizedBox(height: 10),
            Text(isOwnerSeat ? 'SR Voice Owner' : 'User ${index+1}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text(widget.email, style: TextStyle(color: Colors.white54)),
            if(isOwnerSeat) Container(margin: EdgeInsets.only(top: 6), padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Color(0xFFFFD700), borderRadius: BorderRadius.circular(10)), child: Text('OWNER - aponsraponsrsr', style: TextStyle(color: Color(0xFF4A148C), fontWeight: FontWeight.bold, fontSize: 12))),
            SizedBox(height: 20),
            // WALLET INSIDE ID
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(color: Color(0xFF1A0B2E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFFFD700).withOpacity(0.5))),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Wallet', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('Coins: $coins', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 16)),
                  ]),
                  if(isOwnerSeat) SizedBox(height: 10),
                  if(isOwnerSeat) ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: Size(double.infinity, 40)),
                    onPressed: () {
                      setState(() { ownerCoins += 100000; });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('100000 Coin Added! Total: $ownerCoins')));
                    },
                    child: Text('+ Add Unlimited Coin'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            // INVITE INSIDE ID - YOU ASKED
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(color: Color(0xFF1A0B2E), borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Invite Friend', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('My Income: $myIncome', style: TextStyle(color: Colors.white70)),
                    Text('Code: $inviteCode', style: TextStyle(color: Color(0xFFFFD700))),
                  ]),
                  SizedBox(height: 8),
                  Row(children: [
                    Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF4A148C)), onPressed: () { setState(() { myIncome += 100; }); Navigator.pop(context); }, child: Text('Share and invite friends'))),
                    SizedBox(width: 8),
                    ElevatedButton(onPressed: () {}, child: Text('Revenue Details')),
                  ]),
                  TextButton(onPressed: () {}, child: Text('Activity Rules', style: TextStyle(color: Colors.white54, fontSize: 12))),
                ],
              ),
            ),
            SizedBox(height: 10),
            if(isOwner) ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFD700), foregroundColor: Color(0xFF4A148C), minimumSize: Size(double.infinity, 45)),
              onPressed: () => showRoomSettings(),
              child: Text('Group Name Change (Only Owner)'),
            ),
          ],
        ),
      ),
    );
  }

  void showRoomSettings() {
    TextEditingController nameCtrl = TextEditingController(text: groupName);
    TextEditingController annCtrl = TextEditingController(text: announcement);
    String tempLabel = groupLabel;
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setD) => AlertDialog(
          backgroundColor: Color(0xFF2D1B4E),
          title: Text('Room Set', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Room Name', labelStyle: TextStyle(color: Colors.white54))),
              TextField(controller: annCtrl, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Room Announcement', labelStyle: TextStyle(color: Colors.white54))),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: tempLabel,
                dropdownColor: Color(0xFF2D1B4E),
                style: TextStyle(color: Colors.white),
                items: ['Friends','Game','Music','Chat'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setD(() => tempLabel=v!),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(onPressed: () { setState(() { groupName=nameCtrl.text; announcement=annCtrl.text; groupLabel=tempLabel; }); Navigator.pop(context); Navigator.pop(context); }, child: Text('Save', style: TextStyle(color: Color(0xFFFFD700)))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A0B2E),
      appBar: AppBar(
        backgroundColor: Color(0xFF2D1B4E),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(groupName, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          Text('ID: ${Random().nextInt(90000000)+10000000} | $groupLabel | $announcement', style: TextStyle(color: Colors.white54, fontSize: 10), overflow: TextOverflow.ellipsis),
        ]),
        actions: [
          IconButton(icon: Icon(Icons.keep, color: Colors.white), onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Keep - Minimized')))),
          IconButton(icon: Icon(Icons.exit_to_app, color: Colors.white), onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: Column(
        children: [
          // ROOM INFO BANNER
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)]), borderRadius: BorderRadius.circular(12)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('All / Chat / Gift / Notice', style: TextStyle(color: Colors.white70, fontSize: 12)),
              Text('10 Seats | Online: 1', style: TextStyle(color: Color(0xFFFFD700), fontSize: 12)),
            ]),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: 0.75, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: 10,
              itemBuilder: (ctx, i) {
                bool isOwnerSeat = i==0;
                bool isEmpty = seats[i]=='Empty';
                return GestureDetector(
                  onTap: () => showProfile(i),
                  child: Column(
                    children: [
                      Container(
                        width: 60, height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: isOwnerSeat ? LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFA000)]) : null,
                          color: isEmpty ? Color(0xFF2D1B4E) : Color(0xFF4A148C),
                          border: Border.all(color: isOwnerSeat ? Color(0xFFFFD700) : Colors.white24, width: isOwnerSeat ? 3 : 1),
                        ),
                        child: Icon(isOwnerSeat ? Icons.mic : isEmpty ? Icons.chair : Icons.person, color: Colors.white, size: 28),
                      ),
                      SizedBox(height: 4),
                      Text(isOwnerSeat ? 'SR Voice Owner' : isEmpty ? 'খালি সিট' : 'User ${i+1}', style: TextStyle(color: isOwnerSeat ? Color(0xFFFFD700) : Colors.white70, fontSize: 9, fontWeight: isOwnerSeat ? FontWeight.bold : FontWeight.normal), textAlign: TextAlign.center, maxLines: 2),
                      if(isOwnerSeat) Text('Mic ${i+1}', style: TextStyle(color: Colors.white38, fontSize: 8)),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Color(0xFF2D1B4E),
            child: Row(
              children: [
                Icon(Icons.mic, color: Color(0xFFFFD700)),
                SizedBox(width: 10),
                Expanded(child: Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Color(0xFF1A0B2E), borderRadius: BorderRadius.circular(20)), child: Text(announcement, style: TextStyle(color: Colors.white54, fontSize: 12)))),
                SizedBox(width: 10),
                Icon(Icons.emoji_emotions, color: Colors.white54),
                SizedBox(width: 10),
                Icon(Icons.card_giftcard, color: Color(0xFFFFD700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
