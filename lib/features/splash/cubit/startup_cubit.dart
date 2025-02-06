import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/services/database_services.dart';
import 'package:ecommerce_app/features/auth/repository/user_repository.dart';
import 'package:ecommerce_app/features/splash/model/startup_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  StartupCubit({required this.userRepository}) : super(CommonInitialState());

  init() async {
    emit(CommonLoadingState());
    await Future.delayed(Duration(seconds: 2));
    final isFirstTime = await DatabaseServices().isFirstTime;
    await userRepository.init();
    final isLoggedIn =
        userRepository.token.isNotEmpty && userRepository.user != null;
    final param = StartupData(
      isLoggedIn: isLoggedIn,
      isAppOpenedFirstTime: isFirstTime,
    );
    emit(CommonSuccessState(data: param));
  }
}
