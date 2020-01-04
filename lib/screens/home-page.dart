import 'package:flutter/material.dart';
import 'package:google_translate/providers/translate_provider.dart';
import 'package:provider/provider.dart';

import '../components/choose-language.dart';
import '../components/translate-text.dart';
import '../components/list-translate.dart';
import '../components/translate-input.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  TranslateProvider _translateProvider;
  FocusNode _textFocusNode = FocusNode();
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    )..addListener(() {
        this.setState(() {});
      });
  }

  @override
  void dispose() {
    this._controller.dispose();
    this._textFocusNode.dispose();
    super.dispose();
  }

  // Generate animations to enter the text to translate
  _onTextTouched(bool isTouched) {
    Tween _tween = SizeTween(
      begin: Size(0.0, kToolbarHeight),
      end: Size(0.0, 0.0),
    );

    this._animation = _tween.animate(this._controller);

    if (isTouched) {
      FocusScope.of(context).requestFocus(this._textFocusNode);
      this._controller.forward();
    } else {
      FocusScope.of(context).requestFocus(new FocusNode());
      this._controller.reverse();
    }

    _translateProvider.setIsTranslating(isTouched);
  }

  Widget _displaySuggestions() {
    if (_translateProvider.isTranslating) {
      return Container(
        color: Colors.black.withOpacity(0.4),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    _translateProvider = Provider.of<TranslateProvider>(context, listen: true);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(widget.title),
          elevation: 0.0,
        ),
      ),
      body: Column(
        children: <Widget>[
          ChooseLanguage(),
          Stack(
            children: <Widget>[
              Offstage(
                offstage: _translateProvider.isTranslating,
                child: TranslateText(
                  onTextTouched: this._onTextTouched,
                ),
              ),
              Offstage(
                offstage: !_translateProvider.isTranslating,
                child: TranslateInput(
                  onCloseClicked: this._onTextTouched,
                  focusNode: this._textFocusNode,
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: ListTranslate(),
                ),
                this._displaySuggestions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
