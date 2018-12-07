import 'package:flutter/material.dart';

class ChooseLanguage extends StatefulWidget {
  ChooseLanguage({Key key}) : super(key: key);

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey[500],
          ),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      "English",
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.compare_arrows,
                  color: Colors.grey[700],
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      "French",
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
