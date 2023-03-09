import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _firstS = "";
  String _secondS = "";
  double _first = 0;
  double _second = 0;
  bool _dec = false;
  int _decC = 0;
  String _last = '';
  int _bgcl = 0xFFFAFAFA;
  int _rescl = 0xFFFAFAEA;
  int _fgcl = 0xFF000000;
  int _btncl = 0xFFEEEEEE;
  int _bnrcl = 0xFF999999;
  bool _mem = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "test1",
      home: Scaffold(
        backgroundColor: Color(_bgcl),
        appBar: AppBar(
          title: const Text('Calculator'),
          backgroundColor: Color(_bnrcl),
          foregroundColor: Color(_btncl),
          centerTitle: true,
        ),
        body: Column(
          children: [
            IconButton(onPressed: toggle, icon: _mem ? Icon(Icons.nights_stay, color: Colors.white) : Icon(Icons.sunny, color: Colors.black)),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            color: Color(_rescl),
                            child: InkWell(
                              onTap: () => copy(1),
                              child: Text(
                                '$_secondS',
                                style: TextStyle(
                                  color: Color(_fgcl), // custom color
                                  fontSize: Theme.of(context).textTheme.displaySmall?.fontSize, // headline3 font size
                                  fontWeight: Theme.of(context).textTheme.displaySmall?.fontWeight, // headline3 font weight
                                  letterSpacing: Theme.of(context).textTheme.displaySmall?.letterSpacing, // headline3 letter spacing
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            color: Color(_rescl),
                            child: InkWell(
                              onTap: () => copy(0),
                              child: Text(
                                '$_firstS',
                                style: TextStyle(
                                  color: Color(_fgcl), // custom color
                                  fontSize: Theme.of(context).textTheme.displaySmall?.fontSize, // headline3 font size
                                  fontWeight: Theme.of(context).textTheme.displaySmall?.fontWeight, // headline3 font weight
                                  letterSpacing: Theme.of(context).textTheme.displaySmall?.letterSpacing, // headline3 letter spacing
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Row(
              children: [
                _buildButton('CL', () => func('cl')),
                _buildButton('DL', () => func('dl')),
                _buildButton('+/-', () => func('+-')),
              ],
            ),
            Row(
              children: [
                _buildButton('7', () => click(7)),
                _buildButton('8', () => click(8)),
                _buildButton('9', () => click(9)),
                _buildButton('/', () => func('/')),
              ],
            ),
            Row(
              children: [
                _buildButton('4', () => click(4)),
                _buildButton('5', () => click(5)),
                _buildButton('6', () => click(6)),
                _buildButton('*', () => func('*')),
              ],
            ),
            Row(
              children: [
                _buildButton('1', () => click(1)),
                _buildButton('2', () => click(2)),
                _buildButton('3', () => click(3)),
                _buildButton('-', () => func('-')),
              ],
            ),
            Row(
              children: [
                _buildButton('.', () => click(-1)),
                _buildButton('0', () => click(0)),
                _buildButton('=', () => func('=')),
                _buildButton('+', () => func('+')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText, VoidCallback onPressed) {
    return buttonText == 'CL'
        ? Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonText),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(_btncl),
                    foregroundColor: Color(_fgcl),
                    minimumSize: const Size(20, 50)
                ),
              ),
            ),
          )
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonText),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(_btncl),
                    foregroundColor: Color(_fgcl),
                    minimumSize: const Size(20, 50)
                ),
              ),
            ),
          );
  }

  void toggle() {
    setState(() {
      _bgcl = 0xFFFFFFFF - _bgcl + 0xFF000000;
      _rescl = 0xFFFFFFFF - _rescl + 0xFF000000;
      _btncl = 0xFFFFFFFF - _btncl + 0xFF000000;
      _fgcl = 0xFFFFFFFF - _fgcl + 0xFF000000;
      _bnrcl = 0xFFFFFFFF - _bnrcl + 0xFF000000;
      _mem = !_mem;
    });
  }

  void click(int input) {
    setState(() {
      if (input == -2) {
        if (_firstS == "") return;
        if (double.parse(_firstS) < 0) {
          _firstS = _firstS.substring(1, _firstS.length);
        } else {
          if (double.parse(_firstS) > 0) {
            _firstS = '-$_firstS';
          }
        }
        return;
      }
      if (input == -1) {
        if (_dec) return;
        _firstS += '.';
        _dec = true;
        _decC = _firstS.length;
        return;
      }
      _firstS += input.toString();
    });
  }

  void copy(int val) {
    if (val == 0)
      Clipboard.setData(ClipboardData(text: "$_firstS"));
    else
      Clipboard.setData(ClipboardData(text: "$_secondS"));
  }

  void func(String input) {
    setState(() {
      if (input == 'cl') {
        _first = 0;
        _second = 0;
        _firstS = '';
        _secondS = '';
        _dec = false;
      }
      if (input == 'dl') {
        if (_firstS != null && _firstS.length > 0) {
          _firstS = _firstS.substring(0, _firstS.length - 1);
          if (_firstS.length + 1 == _decC) _dec = false;
        }
      } else {
        if (input == '=') {
          funcC(_last);
        } else {
          _last = input;
          funcC(input);
        }
      }
    });
  }

  void funcC(String inp) {
    if (_firstS == '' || inp == '') return;
    _first = double.parse(_firstS);
    if (_secondS != '') {
      _second = double.parse(_secondS);
      switch (inp) {
        case '+':
          {
            _first += _second;
          }
          break;
        case '-':
          {
            _first = _second - _first;
          }
          break;
        case '*':
          {
            _first *= _second;
          }
          break;
        case '/':
          {
            _first = _second / _first;
          }
          break;
      }
    }
    _dec = false;
    _second = _first;
    _secondS = _second.toString();
    _firstS = '';
  }
}
