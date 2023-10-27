import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _currentText = '';
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    _initSpeechRecognizer();
  }

  void _initSpeechRecognizer() async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(
        onResult: (result) {
          setState(() {
            _currentText = result.recognizedWords;
          });
        },
      );
    }
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  void sendMessage(String message) {
    setState(() {
      messages.add(message);
      _currentText = ''; // Clear the input field
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                for (var message in messages)
                  ListTile(
                    title: Text(message),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    if (_speech.isListening) {
                      _speech.stop();
                    } else {
                      _speech.listen();
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: _currentText),
                    onChanged: (text) {
                      // Handle text input changes here
                      setState(() {
                        _currentText = text;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Send the typed message
                    if (_currentText.isNotEmpty) {
                      sendMessage(_currentText);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
