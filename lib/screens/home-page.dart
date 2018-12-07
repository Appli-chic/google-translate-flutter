import 'package:flutter/material.dart';

import '../components/choose-language.dart';
import '../components/translate-text.dart';
import '../components/list-translate.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          ChooseLanguage(),
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: TranslateText(),
          ),
          ListTranslate(),
        ],
      ),
    );
  }
}
