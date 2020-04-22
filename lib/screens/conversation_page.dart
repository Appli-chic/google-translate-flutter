import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';
import 'package:google_translate/components/language_button.dart';
import 'package:google_translate/providers/translate_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage>
    with TickerProviderStateMixin {
  TranslateProvider _translateProvider;
  var _speech = SpeechToText();
  Timer _timer;
  String _talkNowTextLanguage1 = "";
  String _talkNowTextLanguage2 = "";
  String _textToTranslate = "";
  String _textTranslated = "";
  Animation<double> _animation;
  Animation<double> _animation2;
  AnimationController _controller;
  AnimationController _controller2;
  GoogleTranslator _translator = new GoogleTranslator();
  int _personTalkingIndex = 0;

  @override
  void initState() {
    super.initState();
    _initSpeechToText();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _controller2 =
            AnimationController(vsync: this, duration: Duration(seconds: 2))
              ..repeat();
        _animation2 =
            CurvedAnimation(parent: _controller2, curve: Curves.linear);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _timer.cancel();
    _controller.dispose();
    _controller2.dispose();
    _speech.cancel();
  }

  _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) async {
      if (t.tick == 3 && t.isActive) {
        await _stopSpeech();

        if (_personTalkingIndex == 0) {
          await _initSpeechToText();

          setState(() {
            _personTalkingIndex = 1;
          });
        } else if (_personTalkingIndex == 1) {
          await _initSpeechToText();

          setState(() {
            _personTalkingIndex = 0;
          });
        }
      }

      if(t.isActive && _personTalkingIndex != -1 && !_speech.isListening) {
        await _initSpeechToText();
      }
    });
  }

  Future<void> _initSpeechToText() async {
    bool available = await _speech.initialize(
        onStatus: _statusListener, onError: _errorListener);

    if (available) {
      _startTimer();
      _speech.listen(
        onResult: _resultListener,
        localeId: _translateProvider.firstLanguage.code,
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  _stopSpeech() async {
    _timer.cancel();
    await _speech.stop();

    setState(() {
      _textToTranslate = "";
      _textTranslated = "";
    });
  }

  void _resultListener(SpeechRecognitionResult result) {
    if (!result.finalResult && _speech.lastStatus != "notListening") {
      _startTimer();
    }

    // Translate the text
    String firstLanguageCode = "";
    String secondLanguageCode = "";

    if (_personTalkingIndex == 0) {
      firstLanguageCode = _translateProvider.firstLanguage.code;
      secondLanguageCode = _translateProvider.secondLanguage.code;
    } else if (_personTalkingIndex == 1) {
      firstLanguageCode = _translateProvider.secondLanguage.code;
      secondLanguageCode = _translateProvider.firstLanguage.code;
    }

    _translator
        .translate(result.recognizedWords,
            from: firstLanguageCode, to: secondLanguageCode)
        .then((translatedText) {
      setState(() {
        _textTranslated = translatedText;
      });
    });

    setState(() {
      _textToTranslate = result.recognizedWords;
    });
  }

  void _errorListener(SpeechRecognitionError error) {
    print("${error.errorMsg} - ${error.permanent}");
  }

  void _statusListener(String status) {
    print("$status");
  }

  _initTalkNowText() {
    _translator
        .translate("Talk now...",
            from: 'en', to: _translateProvider.firstLanguage.code)
        .then((translatedText) {
      setState(() {
        _talkNowTextLanguage1 = translatedText;
      });
    });

    _translator
        .translate("Talk now...",
            from: 'en', to: _translateProvider.secondLanguage.code)
        .then((translatedText) {
      setState(() {
        _talkNowTextLanguage2 = translatedText;
      });
    });
  }

  String _displaysTextLanguage1() {
    if (_personTalkingIndex == 0) {
      if (_textToTranslate.isEmpty) {
        return _talkNowTextLanguage1;
      } else {
        return _textToTranslate;
      }
    } else if (_personTalkingIndex == 1) {
      if (_textTranslated.isEmpty) {
        return "";
      } else {
        return _textTranslated;
      }
    } else {
      return "";
    }
  }

  String _displaysTextLanguage2() {
    if (_personTalkingIndex == 0) {
      if (_textTranslated.isEmpty) {
        return "";
      } else {
        return _textTranslated;
      }
    } else if (_personTalkingIndex == 1) {
      if (_textToTranslate.isEmpty) {
        return _talkNowTextLanguage2;
      } else {
        return _textToTranslate;
      }
    } else {
      return "";
    }
  }

  Widget _displaysButtonWave2() {
    if (_personTalkingIndex != -1 && _animation2 != null) {
      return Center(
        child: ScaleTransition(
          scale: _animation2,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: Colors.red,
                style: BorderStyle.solid,
              ),
            ),
            height: 140,
            width: 140,
          ),
        ),
      );
    } else {
      return Container(
        height: 140,
        width: 140,
      );
    }
  }

  Widget _displaysButtonWave1() {
    if (_personTalkingIndex != -1 && _animation != null) {
      return Center(
        child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: Colors.red,
                style: BorderStyle.solid,
              ),
            ),
            height: 140,
            width: 140,
          ),
        ),
      );
    } else {
      return Container(
        height: 140,
        width: 140,
      );
    }
  }

  Widget _displaysRecordingButton() {
    if (_personTalkingIndex != -1) {
      return Container(
        margin: EdgeInsets.only(top: 35),
        child: ButtonTheme(
          minWidth: 70.0,
          height: 70.0,
          child: RaisedButton(
            onPressed: () async {
              await _stopSpeech();

              setState(() {
                _personTalkingIndex = -1;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            color: Colors.red,
            child: Icon(
              Icons.mic,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 35),
        child: ButtonTheme(
          minWidth: 70.0,
          height: 70.0,
          child: RaisedButton(
            onPressed: () async {
              await _initSpeechToText();

              setState(() {
                _personTalkingIndex = 0;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            elevation: 0,
            color: Color(0xFFededed),
            child: Icon(
              Icons.mic,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _translateProvider = Provider.of<TranslateProvider>(context, listen: true);

    if (_talkNowTextLanguage1.isEmpty || _talkNowTextLanguage2.isEmpty) {
      _initTalkNowText();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Text(
                _displaysTextLanguage1(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Text(
                _displaysTextLanguage2(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: SizedOverflowBox(
              size: Size.fromHeight(70),
              child: Stack(
                children: <Widget>[
                  _displaysButtonWave1(),
                  _displaysButtonWave2(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: LanguageButton(
                          language: _translateProvider.firstLanguage.name,
                          direction: LanguageButtonDirection.left,
                          isSelected: _personTalkingIndex == 0,
                          onTap: () async {
                            await _stopSpeech();
                            await _initSpeechToText();

                            setState(() {
                              _personTalkingIndex = 0;
                            });
                          },
                        ),
                      ),
                      _displaysRecordingButton(),
                      Expanded(
                        child: LanguageButton(
                          language: _translateProvider.secondLanguage.name,
                          direction: LanguageButtonDirection.right,
                          isSelected: _personTalkingIndex == 1,
                          onTap: () async {
                            await _stopSpeech();
                            await _initSpeechToText();

                            setState(() {
                              _personTalkingIndex = 1;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
