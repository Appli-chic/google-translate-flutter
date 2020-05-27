import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_translate/components/record_button.dart';
import 'package:google_translate/providers/translate_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  TranslateProvider _translateProvider;
  var _speech = SpeechToText();
  Timer _timer;
  String _speechText = "";

  @override
  void initState() {
    super.initState();
    _initSpeechToText();
  }

  @override
  void deactivate() {
    _timer.cancel();
    _speech.cancel();
    _speech.stop();

    super.deactivate();
  }

  @override
  void dispose() {
    _timer.cancel();
    _speech.cancel();
    _speech.stop();

    super.dispose();
  }

  _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (t.tick == 3) {
        t.cancel();
        _speech.stop();
        Navigator.pop(context, _speechText);
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

  void _resultListener(SpeechRecognitionResult result) {
    if (!result.finalResult && _speech.lastStatus != "notListening") {
      _startTimer();
    }

    setState(() {
      _speechText = result.recognizedWords;
    });
  }

  void _errorListener(SpeechRecognitionError error) {
    print("${error.errorMsg} - ${error.permanent}");
  }

  void _statusListener(String status) {
    print("$status");
  }

  void _stopListening() {
    _timer.cancel();
    _speech.stop();
    Navigator.pop(context, _speechText);
  }

  @override
  Widget build(BuildContext context) {
    _translateProvider = Provider.of<TranslateProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          margin: EdgeInsets.only(
            top: kToolbarHeight,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  _speechText != '' ? _speechText : 'Talk now',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          Navigator.pop(context, _speechText);
                        },
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          RecordButton(
                            isActive: true,
                            onClick: (bool isActive) {
                              _stopListening();
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            child: Text(
                              _translateProvider.firstLanguage.name,
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
