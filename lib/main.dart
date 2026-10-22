import 'package:flutter/material.dart';

void main() {
  runApp(SRVoiceChatApp());
}

class SRVoiceChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SR Voice Chat Room',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double walletBalance = 1250.50;
  bool isMicOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SR Voice Chat Room'),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text('৳ $walletBalance',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Wallet Card
          Card(
            margin: EdgeInsets.all(12),
            color: Colors.deepPurple.shade50,
            child: ListTile(
              leading: Icon(Icons.account_balance_wallet,
                  color: Colors.deepPurple, size: 40),
              title: Text('My Wallet',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Balance: ৳ $walletBalance'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: Text('Recharge'),
              ),
            ),
          ),
          // Voice Room
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: 8,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person),
                      ),
                      SizedBox(height: 8),
                      Text('User ${index + 1}'),
                      Icon(Icons.mic_off, size: 16, color: Colors.grey),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(isMicOn ? Icons.mic : Icons.mic_off,
                  color: isMicOn ? Colors.green : Colors.red),
              iconSize: 40,
              onPressed: () {
                setState(() {
                  isMicOn = !isMicOn;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.call_end, color: Colors.red),
              iconSize: 40,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.card_giftcard, color: Colors.pink),
              iconSize: 40,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gift Sent! -10 coins')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
