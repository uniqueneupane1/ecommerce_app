import 'package:ecommerce_app/common/assets.dart';
import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/auth/ui/screens/login_page.dart';
import 'package:ecommerce_app/features/dashboard/ui/screens/dashboard_screens.dart';
import 'package:ecommerce_app/features/splash/cubit/startup_cubit.dart';
import 'package:ecommerce_app/features/splash/model/startup_data.dart';
import 'package:ecommerce_app/features/splash/ui/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocListener<StartupCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonSuccessState<StartupData>) {
            if (state.data.isAppOpenedFirstTime) {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: OnboardingScreen(),
                  type: PageTransitionType.fade,
                ),
                (route) => false,
              );
            } else if (state.data.isLoggedIn) {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: DashboardScreens(),
                  type: PageTransitionType.fade,
                ),
                (route) => false,
              );
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: LoginPage(),
                  type: PageTransitionType.fade,
                ),
                (route) => false,
              );
            }
          }
        },
        child: Container(
          color: Colors.white,
          width: _width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.logo,
                height: 260,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
