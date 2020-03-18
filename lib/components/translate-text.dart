import 'package:flutter/material.dart';
import 'package:google_translate/providers/translate_provider.dart';
import 'package:google_translate/screens/conversation_page.dart';
import 'package:google_translate/screens/record_page.dart';
import 'package:provider/provider.dart';

import 'action-button.dart';

class TranslateText extends StatefulWidget {
  TranslateText({
    Key key,
    this.onTextTouched,
  }) : super(key: key);

  final Function(bool) onTextTouched;

  @override
  _TranslateTextState createState() => _TranslateTextState();
}

class _TranslateTextState extends State<TranslateText> {
  TranslateProvider _translateProvider;

  @override
  Widget build(BuildContext context) {
    _translateProvider = Provider.of<TranslateProvider>(context, listen: true);

    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(0.0),
      elevation: 2.0,
      child: Container(
        height: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  this.widget.onTextTouched(true);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Text(
                    "Enter text",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ActionButton(
                  icon: Icons.camera_alt,
                  text: "Camera",
                ),
                ActionButton(
                  imageIcon: AssetImage("assets/pen.png"),
                  text: "Handwriting",
                ),
                ActionButton(
                  imageIcon: AssetImage("assets/conversation.png"),
                  text: "Conversation",
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConversationPage(
                          firstLanguage: _translateProvider.firstLanguage,
                          secondLanguage: _translateProvider.secondLanguage,
                        ),
                      ),
                    );
                  },
                ),
                ActionButton(
                  onClick: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordPage(
                          firstLanguage: _translateProvider.firstLanguage,
                          secondLanguage: _translateProvider.secondLanguage,
                        ),
                      ),
                    );

                    if (result != null && result != "") {
                      _translateProvider.setTextToTranslate(result);
                      _translateProvider.setIsTranslating(true);
                    }
                  },
                  icon: Icons.keyboard_voice,
                  text: "Voice",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
