import 'package:flutter/material.dart';
import 'package:google_translate/providers/translate_provider.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

class TranslateInput extends StatefulWidget {
  TranslateInput(
      {Key key,
      this.onCloseClicked,
      this.focusNode,})
      : super(key: key);

  final Function(bool) onCloseClicked;
  final FocusNode focusNode;

  @override
  _TranslateInputState createState() => _TranslateInputState();
}

class _TranslateInputState extends State<TranslateInput> {
  TranslateProvider _translateProvider;
  TextEditingController _textEditingController = TextEditingController();
  String _textTranslated = "";
  GoogleTranslator _translator = new GoogleTranslator();

  _onTextChanged(String text) {
    if (text.isNotEmpty) {
      _translateProvider.setTextToTranslate(text);
      _translatingText(text);
    } else {
      _translateProvider.setTextToTranslate("");
      this.setState(() {
        this._textTranslated = "";
      });
    }
  }

  _translatingText(String text) {
    if (text != null && text.isNotEmpty) {
      _translator
          .translate(text,
              from: _translateProvider.firstLanguage.code,
              to: _translateProvider.secondLanguage.code)
          .then((translatedText) {
        if (translatedText != _textTranslated) {
          this.setState(() {
            this._textTranslated = translatedText;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _translateProvider = Provider.of<TranslateProvider>(context, listen: true);
    _textEditingController.text = _translateProvider.textToTranslate;
    _translatingText(_textEditingController.text);

    return Container(
      height: 150.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16.0),
              child: TextField(
                focusNode: this.widget.focusNode,
                controller: this._textEditingController,
                onChanged: this._onTextChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: RawMaterialButton(
                    onPressed: () {
                      if (this._textEditingController.text != "") {
                        this.setState(() {
                          _translateProvider.setTextToTranslate("");
                          this._textEditingController.clear();
                          this._textTranslated = "";
                        });
                      } else {
                        this.widget.onCloseClicked(false);
                      }
                    },
                    child: new Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    shape: new CircleBorder(),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  this._textTranslated,
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
