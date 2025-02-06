import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/homepage/repository/product_repository.dart';

class AddProductInCartCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  AddProductInCartCubit({
    required this.productRepository,
  }) : super(CommonInitialState());

  add(String productId) async {
    emit(CommonLoadingState());
    final res = await productRepository.addToCart(productId);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(data: null)),
    );
  }
}
