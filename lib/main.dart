import 'dart:async';

import 'package:flutter/material.dart';

import 'js/js_func_call.dart';

void main() {
  runApp(const MyApp());
}

var aa='aa';
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'おおおおお'),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List result = ["", ""];
//1秒ごとに一回jsの関数を動かしている
   late Timer timerd;
  var textController;
  bool isSupported=false;


@override
  void initState() {
    // TODO: implement initState
  Future(() async {
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      isSupported = isSupportedBrowser();
    });
  });
    super.initState();
    final aa=isSupportedBrowser()??true;
    print('isSupportedBrowser'+aa.toString());

  if (aa){
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => showDialog(context: context, builder:
            (_) {
          return AlertDialog(
            content: Container(
              height: 350,
              width: 200,
              child: Column(
                children: [
                  Text('お使いのブラウザでは正常な動作をしない場合がございます。\n'
                      '以下主要ブラウザをご利用ください\n'
                      'Chrome\n'
                      'Safari\n'
                      'Edge\n'
                      'Opera 等\n'
                      '※ブラウザのバージョンが古い場合も正常に動作しない場合がございます。\n'
                      '※LINE上のブラウザでは正常に動作しません。'
                  ),


                ],
              ),
            ),

          );
        }
        )
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              (isSupported)?
              'このブラウザは対象のブラウザです':'このブラウザは非対象です',
            ),

            ElevatedButton(onPressed: (){
              setState(() {
                isSupported = isSupportedBrowser();
                aa=checkMicrophonePermission();
              });

            }, child: Text(aa)),
             Text(
              aa,
            ),
            Text(
              aa.toString(),
            ),
            Text(
              result.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //音声入力開始
          vr_function();

          timerd = Timer.periodic(
              const Duration(milliseconds: 100), (_) {
            setState(() {
              result = createList();
              print('remaintext' +
                  'result1' +
                  result[1] +
                  'result0' +
                  result[0]);
            });
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
