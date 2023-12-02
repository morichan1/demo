import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:demo/university_list/university_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'highschool_list/list.dart';
import 'js/js_func_call.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textToAnalyze = "今日はとても楽しい日です。";

  final audioPlayer = AudioPlayer();

  TextEditingController highSchoolController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController universityController = TextEditingController();
//検索結果
  List searchResultHighSchools = [];
  List searchResultUniversities = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: '高校名',
            ),
            controller: highSchoolController,
            onChanged: (text) {
              List resultHighSchoolKana =
              highschool_kana_list
                  .where((univ) =>
                  univ.contains(text))
                  .toList();
              //ひらがなのリストが手に入る

              List resultHighSchoolKanji =
              highschool_kanji_list
                  .where((univ) =>
                  univ.contains(text))
                  .toList();
              //漢字のリストが手に入る

              //ひらがな対応
              if (resultHighSchoolKana
                  .isNotEmpty) {
                List resultIndex = [];
                for (var i
                in resultHighSchoolKana) {
                  resultIndex.add(
                      highschool_kana_list
                          .indexOf(i));
                }
                List result = [];
                for (var i in resultIndex) {
                  result.add(highschool_kanji_list[i]);
                }
                if (result.isNotEmpty) {
                  setState(() {
                    searchResultHighSchools =
                        result;
                  });
                }
              }
              //漢字対応
              else if (resultHighSchoolKanji
                  .isNotEmpty) {
                List result = [];
                for (var i
                in resultHighSchoolKanji) {
                  result.add(i);
                }
                if (result.isNotEmpty) {
                  setState(() {
                    searchResultHighSchools =
                        result;
                  });
                }
              }
              print(searchResultHighSchools);
            },
          ),
          SizedBox(height: 8),
          (searchResultHighSchools.isNotEmpty)
              ? Container(
            color: Colors.grey.shade200,
            height: 200,
            child: GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 10,
              ),
              padding:
              const EdgeInsets.all(8),
              itemCount:
              searchResultHighSchools
                  .length,
              itemBuilder:
                  (BuildContext context,
                  int index) {
                return SizedBox(
                  height: 10,
                  width: 10,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        highSchoolController.text =
                        searchResultHighSchools[
                            index];
                       areaController.text= highschool_map[searchResultHighSchools[
                        index]]['所在位置'];
                        searchResultHighSchools =
                            [];

                      });
                    },
                    child: Container(
                      child: Center(
                          child: Row(
                            children: [

                              Text(
                                  searchResultHighSchools[
                                  index]),
                            ],
                          )),
                    ),
                  ),
                );
              },
            ),
          )
              : SizedBox(),
          TextFormField(
            decoration: InputDecoration(
              labelText: '地域名',
            ),
            controller: areaController,
            onChanged: (text) {

            },

          ),

          TextFormField(
            decoration: InputDecoration(
              labelText: '大学名',
            ),
            controller: universityController,
            onChanged: (text) {
              List resultUniversityKana =
              universities_kana_list
                  .where((univ) =>
                  univ.contains(text))
                  .toList();
              //ひらがなのリストが手に入る

              List resultUniversityKanji =
              universities_kanji_list
                  .where((univ) =>
                  univ.contains(text))
                  .toList();
              //漢字のリストが手に入る

              //ひらがな対応
              if (resultUniversityKana
                  .isNotEmpty) {
                List resultIndex = [];
                for (var i
                in resultUniversityKana) {
                  resultIndex.add(
                      universities_kana_list
                          .indexOf(i));
                }
                List result = [];
                for (var i in resultIndex) {
                  result.add(universities_kanji_list[i]);
                }
                if (result.isNotEmpty) {
                  setState(() {
                    searchResultUniversities =
                        result;
                  });
                }
              }
              //漢字対応
              else if (resultUniversityKanji
                  .isNotEmpty) {
                List result = [];
                for (var i
                in resultUniversityKanji) {
                  result.add(i);
                }
                if (result.isNotEmpty) {
                  setState(() {
                    searchResultUniversities =
                        result;
                  });
                }
              }
              print(searchResultUniversities);
            },
          ),
          SizedBox(height: 8),
          (searchResultUniversities.isNotEmpty)
              ? Container(
            color: Colors.grey.shade200,
            height: 200,
            child: GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 10,
              ),
              padding:
              const EdgeInsets.all(8),
              itemCount:
              searchResultUniversities
                  .length,
              itemBuilder:
                  (BuildContext context,
                  int index) {
                return SizedBox(
                  height: 10,
                  width: 10,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        universityController.text =
                        searchResultUniversities[
                        index];

                        searchResultUniversities =
                        [];

                      });
                    },
                    child: Container(
                      child: Center(
                          child: Row(
                            children: [

                              Text(
                                  searchResultUniversities[
                                  index]),
                            ],
                          )),
                    ),
                  ),
                );
              },
            ),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}
