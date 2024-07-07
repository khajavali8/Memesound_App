import 'package:flutter/material.dart';
import 'tts_service.dart';

void main() => runApp(AnimeMemeVoiceApp());

class AnimeMemeVoiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Meme Voice App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MemePage(),
    );
  }
}

class MemePage extends StatefulWidget {
  @override
  _MemePageState createState() => _MemePageState();
}

class _MemePageState extends State<MemePage> {
  final TtsService _ttsService = TtsService();
  final TextEditingController _controller = TextEditingController();

  final Map<String, List<Meme>> memeLibrary = {
    'smile': [
      Meme(text: 'wow amazing!', imagePath: 'assets/images/2.png'),
      Meme(text: 'hoo yes', imagePath: 'assets/images/1.png'),
      Meme(text: 'yeah! i know', imagePath: 'assets/images/2.smile.png'),
    ],
    'cat': [
      Meme(text: 'Its Tasty!', imagePath: 'assets/images/cat.png'),
      Meme(text: 'Hello!', imagePath: 'assets/images/cat1.png'),
      Meme(text: 'Hoo no', imagePath: 'assets/images/cat2.png'),
      Meme(text: 'Its bad', imagePath: 'assets/images/cat3.png'),
      Meme(text: 'Nice to see you', imagePath: 'assets/images/cat4.png'),
    ],
    'boy': [
      Meme(text: 'I did it!', imagePath: 'assets/images/successkid.png'),
      Meme(text: 'I am Reading', imagePath: 'assets/images/boy.png'),
      Meme(text: 'I have a idea!', imagePath: 'assets/images/boy1.png'),
      Meme(text: 'Wait a min', imagePath: 'assets/images/boy2.png'),
      Meme(text: 'I love you', imagePath: 'assets/images/boy3.png'),
      Meme(text: 'Listening music', imagePath: 'assets/images/boy4.png'),
    ],
    'sad': [
      Meme(text: 'I am depressed', imagePath: 'assets/images/sad.png'),
      Meme(text: 'Okay!', imagePath: 'assets/images/sad1.png'),
      Meme(text: 'its boring', imagePath: 'assets/images/boring.png'),
    ],
    'hero': [
      Meme(text: 'I have a Thor power', imagePath: 'assets/images/hero.png'),
      Meme(text: 'Hey i am Hulk', imagePath: 'assets/images/hero1.png'),
      Meme(text: 'iam a hero', imagePath: 'assets/images/hero2.png'),
      Meme(text: 'its spidey day', imagePath: 'assets/images/hero3.png'),
     ],
    'angry': [
      Meme(text: 'Hate you!', imagePath: 'assets/images/angry.png'),
      Meme(text: 'Noo', imagePath: 'assets/images/angry1.png'),
      Meme(text: 'Its very bad', imagePath: 'assets/images/angry2.png'),
      Meme(text: 'I will shoot you!', imagePath: 'assets/images/angry3.png'),
    ],
    // Add more predefined memes here
  };

  List<Meme> generatedMemes = [];

  void _playMemeVoice(String text) {
    _ttsService.speak(text);
  }

  void _generateMeme() {
    String memeName = _controller.text.trim().toLowerCase();
    if (memeLibrary.containsKey(memeName)) {
      setState(() {
        generatedMemes.clear();
        generatedMemes.addAll(memeLibrary[memeName]!);
      });
      _controller.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Meme not found! Please try another name.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Anime Meme Voice App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter meme name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _generateMeme,
              child: Text('Generate Meme'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: generatedMemes.length,
                itemBuilder: (context, index) {
                  final meme = generatedMemes[index];
                  return MemeButton(
                    text: meme.text,
                    imagePath: meme.imagePath,
                    onPressed: () => _playMemeVoice(meme.text),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MemeButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  MemeButton({required this.text, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 100,
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(width: 8.0), // Space between text and icon
                Icon(
                  Icons.play_circle_outline,
                  color: Colors.blue, // Set the desired color here
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Meme {
  final String text;
  final String imagePath;

  Meme({required this.text, required this.imagePath});
}
