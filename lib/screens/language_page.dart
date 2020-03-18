import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../models/language.dart';
import '../components/language-list-element.dart';

class LanguagePage extends StatefulWidget {
  LanguagePage({Key key, this.title, this.isAutomaticEnabled})
      : super(key: key);

  final String title;
  final bool isAutomaticEnabled;

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final TextEditingController _searchTextController = TextEditingController();
  final List<Language> _languageList = [
    Language('auto', 'Automatic', false, false, false),
    Language('af', 'Afrikaans', false, false, true),
    Language('sq', 'Albanian', false, false, true),
    Language('am', 'Amharic', false, false, false),
    Language('ar', 'Arabic', false, false, true),
    Language('hy', 'Armenian', false, false, false),
    Language('az', 'Azerbaijani', false, false, false),
    Language('eu', 'Basque', false, false, false),
    Language('be', 'Belarusian', false, false, true),
    Language('bn', 'Bengali', false, false, true),
    Language('bs', 'Bosnian', false, false, false),
    Language('bg', 'Bulgarian', false, false, true),
    Language('ca', 'Catalan', false, false, true),
    Language('ceb', 'Cebuano', false, false, false),
    Language('ny', 'Chichewa', false, false, false),
    Language('zh-cn', 'Chinese Simplified', true, false, true),
    Language('zh-tw', 'Chinese Traditional', false, false, true),
    Language('co', 'Corsican', false, false, false),
    Language('hr', 'Croatian', false, false, true),
    Language('cs', 'Czech', false, false, true),
    Language('da', 'Danish', false, false, true),
    Language('nl', 'Dutch', false, false, true),
    Language('en', 'English', true, true, true),
    Language('eo', 'Esperanto', false, false, true),
    Language('et', 'Estonian', false, false, true),
    Language('tl', 'Filipino', false, false, true),
    Language('fi', 'Finnish', false, false, true),
    Language('fr', 'French', true, true, true),
    Language('fy', 'Frisian', false, false, false),
    Language('gl', 'Galician', false, false, true),
    Language('ka', 'Georgian', false, false, true),
    Language('de', 'German', false, false, true),
    Language('el', 'Greek', false, false, true),
    Language('gu', 'Gujarati', false, false, true),
    Language('ht', 'Haitian Creole', false, false, true),
    Language('ha', 'Hausa', false, false, false),
    Language('haw', 'Hawaiian', false, false, false),
    Language('iw', 'Hebrew', false, false, true),
    Language('hi', 'Hindi', false, false, true),
    Language('hmn', 'Hmong', false, false, false),
    Language('hu', 'Hungarian', false, false, true),
    Language('is', 'Icelandic', false, false, true),
    Language('ig', 'Igbo', false, false, false),
    Language('id', 'Indonesian', false, false, true),
    Language('ga', 'Irish', false, false, true),
    Language('it', 'Italian', false, false, true),
    Language('ja', 'Japanese', false, false, false),
    Language('jw', 'Javanese', false, false, true),
    Language('kn', 'Kannada', false, false, true),
    Language('kk', 'Kazakh', false, false, false),
    Language('km', 'Khmer', false, false, false),
    Language('ko', 'Korean', false, false, true),
    Language('ku', 'Kurdish (Kurmanji)', false, false, false),
    Language('ky', 'Kyrgyz', false, false, false),
    Language('lo', 'Lao', false, false, false),
    Language('la', 'Latin', false, false, false),
    Language('lv', 'Latvian', false, false, true),
    Language('lt', 'Lithuanian', false, false, true),
    Language('lb', 'Luxembourgish', false, false, false),
    Language('mk', 'Macedonian', false, false, true),
    Language('mg', 'Malagasy', false, false, false),
    Language('ms', 'Malay', false, false, true),
    Language('ml', 'Malayalam', false, false, false),
    Language('mt', 'Maltese', false, false, true),
    Language('mi', 'Maori', false, false, false),
    Language('mr', 'Marathi', false, false, true),
    Language('mn', 'Mongolian', false, false, false),
    Language('my', 'Myanmar (Burmese)', false, false, false),
    Language('ne', 'Nepali', false, false, false),
    Language('no', 'Norwegian', false, false, true),
    Language('ps', 'Pashto', false, false, false),
    Language('fa', 'Persian', false, false, true),
    Language('pl', 'Polish', false, false, true),
    Language('pt', 'Portuguese', false, false, true),
    Language('ma', 'Punjabi', false, false, false),
    Language('ro', 'Romanian', false, false, true),
    Language('ru', 'Russian', false, false, true),
    Language('sm', 'Samoan', false, false, false),
    Language('gd', 'Scots Gaelic', false, false, false),
    Language('sr', 'Serbian', false, false, false),
    Language('st', 'Sesotho', false, false, false),
    Language('sn', 'Shona', false, false, false),
    Language('sd', 'Sindhi', false, false, false),
    Language('si', 'Sinhala', false, false, false),
    Language('sk', 'Slovak', false, false, true),
    Language('sl', 'Slovenian', false, false, true),
    Language('so', 'Somali', false, false, false),
    Language('es', 'Spanish', false, false, true),
    Language('su', 'Sundanese', false, false, false),
    Language('sw', 'Swahili', false, false, true),
    Language('sv', 'Swedish', false, false, true),
    Language('tg', 'Tajik', false, false, false),
    Language('ta', 'Tamil', false, false, true),
    Language('te', 'Telugu', false, false, true),
    Language('th', 'Thai', false, false, true),
    Language('tr', 'Turkish', false, false, true),
    Language('uk', 'Ukrainian', false, false, true),
    Language('ur', 'Urdu', false, false, true),
    Language('uz', 'Uzbek', false, false, false),
    Language('vi', 'Vietnamese', false, false, true),
    Language('cy', 'Welsh', false, false, true),
    Language('xh', 'Xhosa', false, false, false),
    Language('yi', 'Yiddish', false, false, false),
    Language('yo', 'Yoruba', false, false, false),
    Language('zu', 'Zulu', false, false, false),
  ];

  @override
  void initState() {
    super.initState();

    // Remove the automatic element if disabled
    if (!this.widget.isAutomaticEnabled) {
      var automaticElement = this
          ._languageList
          .where((language) => language.code == 'auto')
          .toList()[0];
      this._languageList.remove(automaticElement);
    }
  }

  // Send back the selected language
  _sendBackLanguage(Language language) {
    Navigator.pop(context, language);
  }

  // Display the delete text icon if we typed text in the search input
  Widget _displayDeleteTextIcon() {
    if (this._searchTextController.text.length > 0) {
      return IconButton(
        icon: Icon(Icons.close),
        color: Colors.grey,
        onPressed: () {
          setState(() {
            _searchTextController.text = "";
          });
        },
      );
    } else {
      return null;
    }
  }

  // Display the list with header if we are not searching
  // Display the list with only languages if we are searching
  Widget _displayTheRightList() {
    if (this._searchTextController.text == "") {
      return this._displayListWithHeaders();
    } else {
      return this._displaySearchedList();
    }
  }

  // Display the language list filtered
  Widget _displaySearchedList() {
    List<Language> searchedList = this
        ._languageList
        .where((e) => e.name
            .toLowerCase()
            .contains(this._searchTextController.text.toLowerCase()))
        .toList();

    // Display
    return Expanded(
      child: ListView.builder(
        itemCount: searchedList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return LanguageListElement(
            language: searchedList[index],
            onSelect: this._sendBackLanguage,
          );
        },
      ),
    );
  }

  // Display the list with headers, means we are not searching
  Widget _displayListWithHeaders() {
    List<Language> recentLanguages =
        this._languageList.where((e) => e.isRecent).toList();

    // Render
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverStickyHeader(
            header: Container(
              height: 60.0,
              color: Colors.blue[600],
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Languages',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => LanguageListElement(
                      language: recentLanguages[i],
                      onSelect: this._sendBackLanguage,
                    ),
                childCount: recentLanguages.length,
              ),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              height: 60.0,
              color: Colors.blue[600],
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'All languages',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => LanguageListElement(
                      language: this._languageList[i],
                      onSelect: this._sendBackLanguage,
                    ),
                childCount: this._languageList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 12.0,
              bottom: 12.0,
              left: 8.0,
              right: 8.0,
            ),
            child: TextField(
              controller: this._searchTextController,
              onChanged: (text) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[600])),
                prefixIcon: Icon(
                  Icons.search,
                  size: 24.0,
                  color: Colors.grey,
                ),
                suffixIcon: this._displayDeleteTextIcon(),
              ),
            ),
          ),
          this._displayTheRightList(),
        ],
      ),
    );
  }
}
