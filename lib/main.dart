import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase Initialization Error: $e");
  }
  runApp(SRVoiceV5());
}

class SRVoiceV5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF1a0b2e)),
      home: AuthCheck(),
    );
  }
}

// Auto Login Check
class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Color(0xFF1a0b2e),
            body: Center(child: CircularProgressIndicator(color: Colors.purpleAccent)),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          return SRV5Room(user: snapshot.data!);
        }
        return LoginScreen();
      },
    );
  }
}

// Login Screen - Gmail Login with Crash Safety
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  Future<void> signInWithGoogle(BuildContext context) async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed: ${e.toString()}"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1a0b2e), Color(0xFF2d1b4e)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic, size: 100, color: Colors.purpleAccent),
                    SizedBox(height: 20),
                    Text("SR VOICE CHAT ROOM", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    Text("V5 - Online Voice App", style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 50),
                    ElevatedButton.icon(
                      onPressed: () => signInWithGoogle(context),
                      icon: Icon(Icons.login),
                      label: Text("Gmail দিয়ে Login করুন"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("একবার Login করলে Auto Login হবে", style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
        ),
      ),
    );
  }
}

// MAIN ROOM - 10 Seat + Wallet + Gift + Game
class SRV5Room extends StatefulWidget {
  final User user;
  SRV5Room({required this.user});
  @override
  _SRV5RoomState createState() => _SRV5RoomState();
}

class _SRV5RoomState extends State<SRV5Room> {
  List<String?> seats = List.filled(10, null);
  int coins = 1000;
  int selectedSeat = -1;

  void takeSeat(int index) {
    setState(() {
      if (seats[index] == null) {
        seats[index] = widget.user.displayName ?? "You";
        selectedSeat = index;
      } else if (seats[index] == widget.user.displayName) {
        seats[index] = null;
      }
    });
  }

  void sendGift() {
    if (coins >= 100) {
      setState(() => coins -= 100);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("🎁 Gift পাঠানো হয়েছে! -100 Coin")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1a0b2e),
        title: Text("SR Voice V5 - 10 Seats"),
        actions: [
          Chip(label: Text("💰 $coins"), backgroundColor: Colors.amber),
          SizedBox(width: 10),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          // Room Info
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(widget.user.photoURL ?? "")),
                SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.user.displayName ?? "User", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(widget.user.email ?? "", style: TextStyle(color: Colors.white54, fontSize: 12)),
                ]),
                Spacer(),
                Icon(Icons.verified, color: Colors.greenAccent),
              ],
            ),
          ),
          // 10 Seats Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: 10,
              itemBuilder: (context, index) {
                bool isOccupied = seats[index] != null;
                return GestureDetector(
                  onTap: () => takeSeat(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isOccupied ? Colors.purple : Colors.white10,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: selectedSeat == index ? Colors.amber : Colors.transparent, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(isOccupied ? Icons.mic : Icons.mic_off, color: Colors.white, size: 30),
                        SizedBox(height: 5),
                        Text("Seat ${index + 1}", style: TextStyle(color: Colors.white, fontSize: 10)),
                        Text(seats[index] ?? "Empty", style: TextStyle(color: Colors.white70, fontSize: 8), overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Bottom Actions - Gift + Game + Wallet
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(color: Color(0xFF2d1b4e), borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionBtn(Icons.card_giftcard, "Gift", Colors.pink, sendGift),
                _actionBtn(Icons.games, "Game", Colors.blue, () => _showGames()),
                _actionBtn(Icons.account_balance_wallet, "Wallet", Colors.amber, () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wallet: $coins Coins")))),
                _actionBtn(Icons.mic, "Mic", Colors.green, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)), SizedBox(height: 5), Text(label, style: TextStyle(color: Colors.white, fontSize: 10))]),
    );
  }

  void _showGames() {
    showModalBottomSheet(context: context, backgroundColor: Color(0xFF1a0b2e), builder: (c) => Container(padding: EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text("🎮 Mini Games", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _gameItem("Ludo"), _gameItem("Carrom"), _gameItem("Tambola"), _gameItem("Quiz"),
      ]),
    ])));
  }

  Widget _gameItem(String name) => Column(children: [CircleAvatar(child: Text(name[0])), SizedBox(height: 5), Text(name, style: TextStyle(color: Colors.white, fontSize: 12))]);
}
