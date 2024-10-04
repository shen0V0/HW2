import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _display = '0'; 
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';
  bool _isOperatorPressed = false;

  void _buttonPressed(String value) {
    setState(() {
      if (value == '+' || value == '-' || value == '*' || value == '/') {
        _firstOperand = double.parse(_display);
        _operator = value;
        _isOperatorPressed = true;
      } else if (value == '=') {
        _secondOperand = double.parse(_display);
        _calculateResult();
      } else if (value == 'C') {
        _display = '0';
        _firstOperand = 0;
        _secondOperand = 0;
        _operator = '';
        _isOperatorPressed = false;
      } else {
        if (_isOperatorPressed) {
          _display = value;
          _isOperatorPressed = false;
        } else {
          _display = _display == '0' ? value : _display + value;
        }
      }
    });
  }

  void _calculateResult() {
    double result = 0;
    switch (_operator) {
      case '+':
        result = _firstOperand + _secondOperand;
        break;
      case '-':
        result = _firstOperand - _secondOperand;
        break;
      case '*':
        result = _firstOperand * _secondOperand;
        break;
      case '/':
        if (_secondOperand != 0) {
          result = _firstOperand / _secondOperand;
        } else {
          _display = 'Error'; 
          return;
        }
        break;
    }
    _display = result.toString();
  }

  Widget _Buttons(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              _Buttons('7'),
              _Buttons('8'),
              _Buttons('9'),
              _Buttons('/'),
            ],
          ),
           ),
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              _Buttons('4'),
              _Buttons('5'),
              _Buttons('6'),
              _Buttons('*'),
            ],
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              _Buttons('1'),
              _Buttons('2'),
              _Buttons('3'),
              _Buttons('-'),
            ],
          ),
          ),
             Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                   _Buttons('C'), 
                _Buttons('0'),
                _Buttons('='),
                _Buttons('+'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}