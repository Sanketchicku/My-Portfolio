//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_particle_background/flutter_particle_background.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_background/animated_background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;
  Animation _animation;

  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.blue[50],
        end: Colors.blue[100],
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.blue[200],
        end: Colors.blue[300],
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.blue[300],
        end: Colors.black,
      ),
    ),
  ]);
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _controller2 = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _animation = Tween(begin: 0.0, end: 80.0)
        .animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller))
          ..addListener(() {
            setState(() {});
          });

    _controller.forward();
  }

  @override
  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SafeArea(
        child: AnimatedBuilder(
            animation: _controller2,
            builder: (context, child) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: background
                    .evaluate(AlwaysStoppedAnimation(_controller2.value)),
                body: Stack(
                  children: [
                    AnimatedBackground(
                      behaviour: RacingLinesBehaviour(
                        direction: LineDirection.Ttb,
                        numLines: 2000,
                      ),
                      vsync: this,
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 100.0,
                                backgroundImage: AssetImage('images/s.jpg'),
                              ),
                              Button(
                                  c: Colors.green,
                                  h: _animation.value,
                                  p: 'images/stopstalk.png',
                                  t: 'Click to see my STOPSTALK profile',
                                  wb: 'https://www.stopstalk.com/user/profile/sanketchicku'),
                              SizedBox(
                                height: 20,
                              ),
                              Button(
                                  c: Colors.green,
                                  h: _animation.value,
                                  p: 'images/ln.jpeg',
                                  t: 'Click to see my LINKEDIN profile',
                                  wb: 'https://in.linkedin.com/in/sanket-kumar-mishra-376425164'),
                              SizedBox(
                                height: 20,
                              ),
                              Button(
                                c: Colors.green,
                                h: _animation.value,
                                p: 'images/tt.jpeg',
                                t: 'Click to see my TWITTER profile',
                                wb: 'https://twitter.com/sanketchicku',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Button(
                                c: Colors.green,
                                h: _animation.value,
                                p: 'images/medim.png',
                                t: 'Click to see my MEDIUM profile',
                                wb: 'https://medium.com/@snktmishra2',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Button(
                                  c: Colors.green,
                                  h: _animation.value,
                                  p: 'images/fb.jpeg',
                                  t: 'Click to see my FACEBOOK profile',
                                  wb: 'https://www.facebook.com/sanket.mishra.39/'),
                              SizedBox(
                                height: 20,
                              ),
                              Button(
                                  c: Colors.green,
                                  h: _animation.value,
                                  p: 'images/insta.png',
                                  t: 'Click to see my INSTA profile',
                                  wb: 'https://www.instagram.com/sanketchicku/'),
                              SizedBox(
                                height: 20,
                              ),
                              Button(
                                  c: Colors.green,
                                  h: _animation.value,
                                  p: 'images/insta.png',
                                  t: 'WHO AM I',
                                  wb: 'https://pbs.twimg.com/media/ETNMew6UwAMg8ur.jpg'),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

// ignore: must_be_immutable
class Button extends StatefulWidget {
  Color c;
  double h;
  String p;
  String t;
  String wb;
  Button({this.c, this.h, this.p, this.t, this.wb});
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _launchURLBrowser(widget.wb);
          widget.c = Colors.green;
        });
      },
      onHover: (value) {
        if (value)
          setState(() {
            widget.c = Colors.black;
            widget.h = 65;
          });
        else {
          setState(() {
            widget.c = Colors.green;
            widget.h = 80;
          });
        }
      },
      child: Container(
        height: widget.h,
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: [
              BoxShadow(
                color: widget.c,
                blurRadius: 0.0,
                offset: Offset(10.0, 10.0),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple,
                Colors.purple[50],
              ],
            )),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              widget.p,
            ),
          ),
          Center(
            child: Text(
              widget.t,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decorationStyle: TextDecorationStyle.dotted,
                decorationColor: Colors.yellow,
                decorationThickness: 0.5,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

_launchURLBrowser(String s) async {
  String url = s;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
