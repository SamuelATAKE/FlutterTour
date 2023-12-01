// ignore_for_file: unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showcaseview/showcaseview.dart';

class Homee extends StatefulWidget {
  const Homee({super.key});

  @override
  State<Homee> createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  // int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ShowCase',
      theme: ThemeData(
        primaryColor: const Color(0xffEE5366),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ShowCaseWidget(
          onStart: (index, key) {
            print('onStart: $index, $key');
          },
          onComplete: (index, key) {
            print('onComplete: $index, $key');
            if (index == 4) {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle.light.copyWith(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                ),
              );
            }
          },
          blurValue: 1,
          builder: Builder(builder: (context) => const MailPage()),
          autoPlayDelay: const Duration(seconds: 3),
        ),
      ),
    );
  }
}

class MailPage extends StatefulWidget {
  const MailPage({Key? key}) : super(key: key);

  @override
  _MailPageState createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  // final GlobalKey _three = GlobalKey();
  // final GlobalKey _four = GlobalKey();
  final GlobalKey _five = GlobalKey();

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 8),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xffF9F9F9),
                            border: Border.all(
                              color: const Color(0xffF3F3F3),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Showcase(
                                      key: _one,
                                      description: 'Tap to see menu options',
                                      disableDefaultTargetGestures: true,
                                      onBarrierClick: () =>
                                          debugPrint('Barrier clicked'),
                                      child: GestureDetector(
                                        onTap: () =>
                                            debugPrint('menu button clicked'),
                                        child: Icon(
                                          Icons.menu,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Search email',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.search,
                                      color: Color(0xffADADAD),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Showcase(
                      targetPadding: const EdgeInsets.all(5),
                      key: _two,
                      title: 'Profile',
                      description:
                          "Tap to see profile which contains user's name, profile picture, mobile number and country",
                      tooltipBackgroundColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      targetShapeBorder: const CircleBorder(),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Image.asset('assets/simform.jpeg'),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: const Text(
                    'PRIMARY',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 8))
          ],
        ),
      ),
      floatingActionButton: Showcase(
        key: _five,
        title: 'Compose Mail',
        description: 'Click here to compose mail',
        targetShapeBorder: const CircleBorder(),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            setState(() {
              ShowCaseWidget.of(context).startShowCase([_one]);
            });
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
