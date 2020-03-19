import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_translate/providers/translate_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> with TickerProviderStateMixin {
  TranslateProvider _translateProvider;
  var _speech = SpeechToText();
  Timer _timer;
  String _lastWords = "";
  Animation<double> _animation;
  Animation<double> _animation2;
  AnimationController _controller;
  AnimationController _controller2;

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

    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (t.tick == 3) {
        t.cancel();
        _speech.stop();
        Navigator.pop(context, _lastWords);
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
      _lastWords = result.recognizedWords;
    });
  }

  void _errorListener(SpeechRecognitionError error) {
    print("${error.errorMsg} - ${error.permanent}");
  }

  void _statusListener(String status) {
    print("$status");
  }

  void _stopListening() {
    _speech.stop();
    Navigator.pop(context, _lastWords);
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
              top: kToolbarHeight, left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  _lastWords != '' ? _lastWords : 'Talk now',
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
                          Navigator.pop(context, _lastWords);
                        },
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Center(
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
                              ),
                              _animation2 != null
                                  ? Center(
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
                                    )
                                  : Container(),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 35),
                                  child: ButtonTheme(
                                    minWidth: 70.0,
                                    height: 70.0,
                                    child: RaisedButton(
                                      onPressed: () {
                                        _stopListening();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      color: Colors.red,
                                      child: Icon(
                                        Icons.mic,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
