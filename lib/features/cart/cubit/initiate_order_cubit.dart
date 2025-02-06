import 'package:ecommerce_app/features/cart/model/cart.dart';
import 'package:ecommerce_app/features/cart/repository/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/common/bloc/common_state.dart';

class UpdateCartQuantityCubit extends Cubit<CommonState> {
  final CartRepository cartRepository;
  UpdateCartQuantityCubit({
    required this.cartRepository,
  }) : super(CommonInitialState());

  update({required String cartId, required int quantity}) async {
    emit(CommonLoadingState());
    final res = await cartRepository.updateCartItemQuantity(
      cartItemId: cartId,
      quantity: quantity,
    );
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<Cart>(data: data)),
    );
  }
}
