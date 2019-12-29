import 'package:flutter/material.dart';
import 'package:google_translate/models/language.dart';
import 'package:google_translate/screens/record_page.dart';

import 'action-button.dart';

class TranslateText extends StatefulWidget {
  TranslateText({
    Key key,
    this.onTextTouched,
    @required this.firstLanguage,
    @required this.secondLanguage,
  }) : super(key: key);

  final Function(bool) onTextTouched;
  final Language firstLanguage;
  final Language secondLanguage;

  @override
  _TranslateTextState createState() => _TranslateTextState();
}

class _TranslateTextState extends State<TranslateText> {
  @override
  Widget build(BuildContext context) {
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
                ),
                ActionButton(
                  onClick: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecordPage(
                              firstLanguage: widget.firstLanguage,
                              secondLanguage: widget.secondLanguage,
                            ),
                      ),
                    );

                    if(result != null && result != "") {
                      // TODO: Write the text
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
