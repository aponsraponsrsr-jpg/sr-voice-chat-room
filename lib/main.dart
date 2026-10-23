import 'package:flutter/material.dart';
void main() => runApp(SRVoiceApp());
class SRVoiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('SR Voice Chat Room'), backgroundColor: Color(0xFF6A1B9A)),
        body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.mic, size: 80, color: Color(0xFF6A1B9A)), SizedBox(height: 20), Text('SR Voice V4 Fixed!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))])),
      ),
    );
  }
}
