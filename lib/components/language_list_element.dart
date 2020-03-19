import 'package:flutter/material.dart';

import '../models/language.dart';

class LanguageListElement extends StatefulWidget {
  LanguageListElement({Key key, this.language, this.onSelect})
      : super(key: key);

  final Language language;
  final Function(Language) onSelect;

  @override
  _LanguageListElementState createState() => _LanguageListElementState();
}

class _LanguageListElementState extends State<LanguageListElement> {

  Widget _displayTrailingIcon() {
    if(this.widget.language.isDownloadable) {
      if(this.widget.language.isDownloaded) {
        return Icon(Icons.check_circle);
      } else {
        return Icon(Icons.file_download);
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.widget.language.name),
      trailing: this._displayTrailingIcon(),
      onTap: () {
        this.widget.onSelect(this.widget.language);
      },
    );
  }
}
