import 'package:flutter/material.dart';
import '../models/translate.dart';

class ListTranslate extends StatefulWidget {
  ListTranslate({Key key}) : super(key: key);

  @override
  _ListTranslateState createState() => _ListTranslateState();
}

class _ListTranslateState extends State<ListTranslate> {
  List<Translate> _items = [
    Translate(
      "yellowish",
      "jaunâtre",
      true,
    ),
    Translate(
      "to spew out",
      "cracher",
      false,
    ),
    Translate(
      "pour combler",
      "to fill",
      false,
    ),
    Translate(
      "frisson",
      "thrill",
      false,
    ),
    Translate(
      "chime",
      "carillon",
      true,
    ),
    Translate(
      "gaz de chiste",
      "shale gas",
      false,
    ),
    Translate(
      "a bold statement",
      "une déclaration audacieuse",
      true,
    ),
    Translate(
      "slick",
      "nappe",
      false,
    ),
    Translate(
      "sketch",
      "dessin",
      false,
    ),
    Translate(
      "sketch",
      "dessin",
      false,
    ),
    Translate(
      "serve",
      "desservir",
      false,
    ),
  ];

  Widget _displayCard(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
      ),
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 0.5),
      child: Container(
        height: 80.0,
        padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    _items[index].text,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _items[index].translatedText,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                _items[index].isStarred ? Icons.star : Icons.star_border,
                size: 23.0,
                color: _items[index].isStarred ? Colors.blue[600] : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return _displayCard(index);
      },
    );
  }
}
