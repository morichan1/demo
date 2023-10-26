@JS()
// jsファイル名を記載
library js_func;
import 'package:js/js.dart';

// jsファイルから呼び出したい関数をCall
@JS('callJsFunc')
external String callJsFunc(String message);

//音声入力を開始するもの
@JS('vr_function')
external void vr_function();

//音声入力したものをflutter側におくる
@JS('createList')
external List createList();

//文章を切る。listを削除する
@JS('endRecoding')
external void endRecoding();

@JS('checkMicrophonePermission')
external String checkMicrophonePermission();

@JS('isSupportedBrowser')
external bool isSupportedBrowser();
