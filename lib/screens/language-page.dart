import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  LanguagePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        elevation: 0.0,
      ),
      body: Column(
      ),
    );
  }
}