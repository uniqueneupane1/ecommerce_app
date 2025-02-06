// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/auth/repository/user_repository.dart';

class LoginCubit extends Cubit<CommonState> {
  final UserRepository repository;
  LoginCubit({required this.repository}) : super(CommonInitialState());

  login({
    required String email,
    required String password,
  }) async {
    emit(CommonLoadingState());
    final res = await repository.login(email: email, password: password);
    res.fold(
      (err) {
        emit(CommonErrorState(message: err));
      },
      (data) {
        emit(CommonSuccessState(data: null));
      },
    );
  }
}
