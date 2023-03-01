import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  print("Hello");
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "test1",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("jan"),
        ),
        body: Column(
        children: [
          Text('$_secondS'),
          Text('$_firstS'),
          Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()=> func('cl'), child: Text('cl')),
                TextButton(onPressed: ()=> func('dl'), child: Text('dl')),
                TextButton(onPressed: ()=> func(''), child: Text(' ')),
                TextButton(onPressed: ()=> func(''), child: Text(' ')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()=> click(1), child: Text('1')),
                TextButton(onPressed: ()=> click(2), child: Text('2')),
                TextButton(onPressed: ()=> click(3), child: Text('3')),
                TextButton(onPressed: ()=> func('+'), child: Text('+')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()=> click(4), child: Text('4')),
                TextButton(onPressed: ()=> click(5), child: Text('5')),
                TextButton(onPressed: ()=> click(6), child: Text('6')),
                TextButton(onPressed: ()=> func('-'), child: Text('-')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()=> click(7), child: Text('7')),
                TextButton(onPressed: ()=> click(8), child: Text('8')),
                TextButton(onPressed: ()=> click(9), child: Text('9')),
                TextButton(onPressed: ()=> func('*'), child: Text('*')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()=> click(-1), child: Text(',')),
                TextButton(onPressed: ()=> click(0), child: Text('0')),
                TextButton(onPressed: ()=> func('dl'), child: Text('del')),
                TextButton(onPressed: ()=> func('/'), child: Text('/')),
              ],
            ),
          ],
        ),
        ],
        ),
      ),
    );
  }

  void click(int input){
      setState(() {
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
        if (_firstS == ''||input=='') return;
        _first=double.parse(_firstS);
        if (_secondS != '') {
          _second=double.parse(_secondS);
          switch (input) {
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
        _second=_first;
        _secondS=_second.toString();
        _firstS = '';
      }
    });
  }
}