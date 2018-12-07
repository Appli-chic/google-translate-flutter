import 'package:flutter/material.dart';

class TranslateText extends StatefulWidget {
  TranslateText({Key key}) : super(key: key);

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
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          height: 150.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
                  Material(
                    color: Colors.white,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                      onPressed: () {},
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.camera_alt,
                            size: 23.0,
                            color: Colors.blue[800],
                          ),
                          Text(
                            "Camera",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                      onPressed: () {},
                      child: Column(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage("assets/pen.png"),
                            size: 23.0,
                            color: Colors.blue[800],
                          ),
                          Text(
                            "Handwriting",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                      onPressed: () {},
                      child: Column(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage("assets/conversation.png"),
                            size: 23.0,
                            color: Colors.blue[800],
                          ),
                          Text(
                            "Conversation",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                      onPressed: () {},
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.keyboard_voice,
                            size: 23.0,
                            color: Colors.blue[800],
                          ),
                          Text(
                            "Voice",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
