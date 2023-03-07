import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
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
  bool _mem = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "test1",
      home: Scaffold(
        backgroundColor: Color(_bgcl),
        body: Column(
        children: [
          Switch(value: _mem, onChanged: (bool)=> toggle(true)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ElevatedButton(onPressed: ()=> copy(1), child: Text('$_secondS'), style: ElevatedButton.styleFrom(minimumSize: Size(120, 35), backgroundColor: Color(_rescl), foregroundColor: Color(_fgcl))),
              ElevatedButton(onPressed: ()=> copy(0), child: Text('$_firstS'), style: ElevatedButton.styleFrom(minimumSize: Size(120, 35), backgroundColor: Color(_rescl), foregroundColor: Color(_fgcl))),
            ],
          ),
          Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()=> func('cl'), child: Text('cl'), style: TextButton.styleFrom(minimumSize: Size(120, 35), backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> func('dl'), child: Text('dl'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> click(-2), child: Text('+/-'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()=> click(1), child: Text('1'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> click(2), child: Text('2'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> click(3), child: Text('3'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> func('+'), child: Text('+'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()=> click(4), child: Text('4'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> click(5), child: Text('5'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> click(6), child: Text('6'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> func('-'), child: Text('-'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()=> click(7), child: Text('7'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> click(8), child: Text('8'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> click(9), child: Text('9'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> func('*'), child: Text('*'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()=> click(-1), child: Text(','), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> click(0), child: Text('0'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> func('='), child: Text('='), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
                TextButton(onPressed: ()=> func('/'), child: Text('/'), style: TextButton.styleFrom(backgroundColor: Color(_btncl), foregroundColor: Color(_fgcl))),
              ],
            ),
          ],
        ),
        ],
        ),
      ),
    );
  }
  void toggle (bool? al){
    setState(() {
      _bgcl = 0xFFFFFFFF - _bgcl + 0xFF000000;
      _rescl = 0xFFFFFFFF - _rescl + 0xFF000000;
      _btncl = 0xFFFFFFFF - _btncl + 0xFF000000;
      _fgcl = 0xFFFFFFFF - _fgcl + 0xFF000000;
      _mem=!_mem;
    });
  }
  void click(int input){
      setState(() {
        if(input==-2){
          if(_firstS=="")
            return;
          if(double.parse(_firstS)<0){
            _firstS = _firstS.substring(1, _firstS.length);
          }else{
            if(double.parse(_firstS)>0){
              _firstS='-$_firstS';
            }
          }
          return;
        }
        if(input==-1){
          if(_dec)
            return;
          _firstS+='.';
          _dec=true;
          _decC = _firstS.length;
          return;
        }
        _firstS+=input.toString();
      });
  }
  void copy(int val){
    if(val==0)
      Clipboard.setData(ClipboardData(text: "$_firstS"));
    else
      Clipboard.setData(ClipboardData(text: "$_secondS"));
  }
  void func(String input){
    setState(() {
      if(input=='cl') {
        _first=0;
        _second=0;
        _firstS='';
        _secondS='';
        _dec=false;
    }
      if(input=='dl') {
        if (_firstS != null && _firstS.length > 0) {
          _firstS = _firstS.substring(0, _firstS.length - 1);
          if(_firstS.length+1==_decC)
            _dec = false;
        }

      }else {
        if (input == '=') {
          funcC(_last);
        } else {
          _last = input;
          funcC(input);
        }
      }
    });
  }
  void funcC(String inp){
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