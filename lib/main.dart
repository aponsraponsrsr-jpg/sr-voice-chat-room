import 'package:flutter/material.dart';
import 'dart:math';

void main() { runApp(SRVoiceChatApp()); }

class SRVoiceChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SR Voice Chat Room V2',
      home: LoginPage(),
    );
  }
}

String generateRandomID() {
  final r = Random();
  return (1000000 + r.nextInt(9000000)).toString();
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic, size: 100, color: Colors.purple),
            Text('SR Voice Chat Room V2', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.mail),
              label: Text('Gmail Login - Random ID'),
              onPressed: () {
                String newID = generateRandomID();
                Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage(userID: newID)));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String userID;
  HomePage({required this.userID});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int coins = 1000;
  bool isOwner = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ID: ${widget.userID}'),
        actions: [IconButton(icon: Icon(Icons.admin_panel_settings), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OwnerPanel())))],
      ),
      body: Column(
        children: [
          Card(child: ListTile(title: Text('Wallet: $coins Coins'), subtitle: Text('MIX ID RANDOM 7 DIGIT: ${widget.userID}'))),
          Expanded(child: ListView.builder(itemCount: 10, itemBuilder: (c,i) => ListTile(title: Text('Room ${i+1}'), subtitle: Text('ID: ${generateRandomID()}')))),
        ],
      ),
    );
  }
}

class OwnerPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PRIVATE Owner Panel')),
      body: ListView(children: [
        ListTile(title: Text('Give Unlimited Coins')),
        ListTile(title: Text('Give Entry Effect')),
        ListTile(title: Text('Give Frame')),
        ListTile(title: Text('Gift Box Control')),
        ListTile(title: Text('Games Control')),
      ]),
    );
  }
}
