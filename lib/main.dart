import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/features/auth/repository/user_repository.dart';
import 'package:ecommerce_app/features/cart/repository/cart_repository.dart';
import 'package:ecommerce_app/features/homepage/repository/product_repository.dart';
import 'package:ecommerce_app/features/splash/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProductRepository(
            userRepository: context.read<UserRepository>()
          ),
        ),
        RepositoryProvider(
          create: (context) => CartRepository(
            userRepository: context.read<UserRepository>()
          ),
        ),
      ],
      child: GlobalLoaderOverlay(
        child: MaterialApp(
          title: 'Ecommerce',
          theme: ThemeData(
            primaryColor: CustomTheme.primaryColor,
            useMaterial3: false,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
