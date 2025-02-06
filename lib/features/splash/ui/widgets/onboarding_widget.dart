import 'package:ecommerce_app/common/assets.dart';
import 'package:ecommerce_app/common/services/database_services.dart';
import 'package:ecommerce_app/features/auth/ui/screens/login_page.dart';
import 'package:faker/faker.dart' hide Image;
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  List<PageViewModel> _items = [];
  final databaseService = DatabaseServices();

  @override
  void initState() {
    super.initState();
    _items = [
      Assets.traveling,
      Assets.myUniverse,
      Assets.coding,
    ].map(
      (img) {
        return PageViewModel(
          title: Faker().company.name(),
          body: Faker().lorem.sentences(3).join(". "),
          image: Center(
            child: Image.asset(
              img,
              height: 200,
              width: 200,
            ),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: _items,
        onDone: () async {
          await databaseService.setAppAsOpened();
          Navigator.of(context).pushReplacement(
            PageTransition(
              type: PageTransitionType.fade,
              child: LoginPage(),
            ),
          );
        },
        onSkip: () async {
          await databaseService.setAppAsOpened();
          Navigator.of(context).pushReplacement(
            PageTransition(
              type: PageTransitionType.fade,
              child: LoginPage(),
            ),
          );
        },
        showSkipButton: true,
        skip: Text("Skip"),
        done: Text("Done"),
        next: Text("Next"),
      ),
    );
  }
}
