// SR VOICE CHAT ROOM V3 FINAL - OWNER: aponsraponsrsr@gmail.com
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(SRVoiceApp());

class SRVoiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SR Voice Chat Room',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoginScreen(),
    );
  }
}

class UserModel {
  String gmail, name, photo;
  int coins;
  bool isOwner, isAdmin;
  UserModel({
    required this.gmail,
    required this.name,
    required this.photo,
    this.coins = 0,
    this.isOwner = false,
    this.isAdmin = false,
  });
}

class MicSeat {
  int id;
  UserModel? user;
  MicSeat({required this.id, this.user});
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> phoneGmails = [
    'aponsraponsrsr@gmail.com',
    'srvoice.official@gmail.com',
    'owner.srvoice@gmail.com',
    'test.user1@gmail.com',
    'test.user2@gmail.com',
  ];

  String OWNER_GMAIL = 'aponsraponsrsr@gmail.com';

  void showGmailList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'ফোনের Gmail সিলেক্ট করুন',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              ...phoneGmails.map((gmail) => ListTile(
                leading: CircleAvatar(
                  child: Text(gmail[0].toUpperCase()),
                  backgroundColor: Colors.redAccent,
                ),
                title: Text(gmail),
                subtitle: Text(
                  gmail == OWNER_GMAIL ? 'OWNER - Unlimited Wallet' : 'User',
                ),
                trailing: gmail == OWNER_GMAIL
                    ? Icon(Icons.verified, color: Colors.blue)
                    : null,
                onTap: () {
                  Navigator.pop(ctx);
                  loginWithGmail(gmail);
                },
              )).toList(),
            ],
          ),
        );
      },
    );
  }

  void loginWithGmail(String gmail) {
    bool isOwner = gmail == OWNER_GMAIL;
    UserModel user = UserModel(
      gmail: gmail,
      name: isOwner ? 'SR Voice Owner' : 'User ${Random().nextInt(1000)}',
      photo: 'https://i.pravatar.cc/150?u=$gmail',
      coins: isOwner ? 1000000 : 5000,
      isOwner: isOwner,
      isAdmin: isOwner,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ChatRoomScreen(currentUser: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic, size: 80, color: Colors.purpleAccent),
            SizedBox(height: 15),
            Text(
              'SR Voice Chat Room',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              'Owner: aponsraponsrsr@gmail.com',
              style: TextStyle(color: Colors.amber, fontSize: 12),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: showGmailList,
              child: Container(
                width: 280,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      'Gmail দিয়ে Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatRoomScreen extends StatefulWidget {
  final UserModel currentUser;
  ChatRoomScreen({required this.currentUser});
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late List<MicSeat> seats;
  String roomName = 'SR Voice Official Room';
  String roomTheme = 'Dark';
  Map<String, Color> themeColors = {
    'Dark': Color(0xFF121212),
    'Purple': Color(0xFF2D1B4E),
    'Blue': Color(0xFF0F2C4D),
    'Green': Color(0xFF1B4D2D),
    'Red': Color(0xFF4D1B1B),
    'Golden': Color(0xFF4D3D1B),
  };

  @override
  void initState() {
    super.initState();
    seats = List.generate(15, (i) => MicSeat(id: i + 1));
    if (widget.currentUser.isOwner) {
      seats[0].user = widget.currentUser;
    }
  }

  void sitOnSeat(int index) {
    setState(() {
      if (seats[index].user == null) {
        seats[index].user = widget.currentUser;
      } else if (seats[index].user!.gmail == widget.currentUser.gmail) {
        seats[index].user = null;
      }
    });
  }

  void showProfile(UserModel user) {
    bool isMe = user.gmail == widget.currentUser.gmail;
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photo),
            ),
            SizedBox(height: 10),
            Text(
              user.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              user.gmail,
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            if (user.isOwner)
              Chip(
                label: Text('OWNER - aponsraponsrsr'),
                backgroundColor: Colors.amber,
              ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Wallet (ID এর ভিতরে)'),
                      Icon(Icons.wallet, color: Colors.amber),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Coins:'),
                      Text(
                        '${user.coins}',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  if (isMe && widget.currentUser.isOwner)
                    ElevatedButton.icon(
                      icon: Icon(Icons.add),
                      label: Text('Add Unlimited Coin'),
                      onPressed: () {
                        setState(() => widget.currentUser.coins += 100000);
                        Navigator.pop(ctx);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(double.infinity, 45),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 10),
            if (isMe && widget.currentUser.isOwner)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  editGroup();
                },
                child: Text('Group Name Change (Only Owner)'),
              ),
          ],
        ),
      ),
    );
  }

  void editGroup() {
    TextEditingController c = TextEditingController(text: roomName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Group Name'),
        content: TextField(controller: c),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => roomName = c.text);
              Navigator.pop(ctx);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColors[roomTheme],
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SR Voice Chat Room', style: TextStyle(fontSize: 14)),
            Text(roomName, style: TextStyle(fontSize: 11)),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => showProfile(widget.currentUser),
            child: Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.currentUser.photo),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.black26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Owner: aponsraponsrsr@gmail.com',
                  style: TextStyle(fontSize: 10, color: Colors.amber),
                ),
                Text('15 Seats', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.85,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 15,
              itemBuilder: (ctx, i) {
                var s = seats[i];
                bool occ = s.user != null;
                return GestureDetector(
                  onTap: () => sitOnSeat(i),
                  onLongPress: () => occ ? showProfile(s.user!) : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: occ ? Colors.white10 : Colors.white12,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: occ ? Colors.purpleAccent : Colors.white24,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: occ
                              ? NetworkImage(s.user!.photo)
                              : null,
                          child: occ ? null : Icon(Icons.person),
                        ),
                        SizedBox(height: 5),
                        Text(
                          occ ? s.user!.name : 'খালি সিট',
                          style: TextStyle(fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Mic ${s.id}',
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
