import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(LotteryApp());

class LotteryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lottery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LotteryPage(),
    );
  }
}

class LotteryPage extends StatefulWidget {
  @override
  _LotteryPageState createState() => _LotteryPageState();
}

class _LotteryPageState extends State<LotteryPage> {
  String result = '';
  String debugInfo = ''; // Added for debugging
  List<int> numbers = List.generate(6, (index) => 0);
  List<TextEditingController> numberControllers =
      List.generate(6, (index) => TextEditingController());

  void generateNumbers() {
    setState(() {
      numbers = List.generate(6, (index) => Random().nextInt(49) + 1);
      result = '';
      debugInfo = ''; // Clear debug info
      for (int i = 0; i < 6; i++) {
        numberControllers[i].clear();
      }
    });
  }

  void checkNumbers() {
    setState(() {
      numbers.sort();
      result = 'Your numbers: ${numbers.toString()}';
      debugInfo = 'Generated numbers: ${numbers.toString()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lottery')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hope you win:',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Container(
                  width: 50.0,
                  child: TextField(
                    controller: numberControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            ),
            SizedBox(height: 16.0),
            Text(
              '$result',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: generateNumbers,
              child: Text('Generate new lottery Numbers'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                for (int i = 0; i < 6; i++) {
                  numbers[i] = int.parse(numberControllers[i].text);
                }
                checkNumbers();
              },
              child: Text('Check the winning numbers'),
            ),
            SizedBox(height: 16.0),
            Text(
              '$debugInfo', // Display debug info
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
