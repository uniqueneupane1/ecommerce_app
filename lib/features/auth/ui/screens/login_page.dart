import 'package:ecommerce_app/features/auth/cubit/login_cubit.dart';
import 'package:ecommerce_app/features/auth/repository/user_repository.dart';
import 'package:ecommerce_app/features/auth/ui/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        repository: context.read<UserRepository>(),
      ),
      child: const LoginWidgets(),
    );
  }
}
