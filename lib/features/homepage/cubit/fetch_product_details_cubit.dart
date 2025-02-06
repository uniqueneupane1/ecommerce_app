import 'package:ecommerce_app/features/homepage/model/products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/homepage/repository/product_repository.dart';

class FetchProductDetailsCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  FetchProductDetailsCubit({
    required this.productRepository,
  }) : super(CommonInitialState());

  Product? _product;

  fetchDetails(String productId) async {
    emit(CommonLoadingState());
    final res = await productRepository.fetchProductDetails(productId);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) {
        _product = data;
        emit(CommonSuccessState<Product>(data: data));
      }
    );
  }

  addedInCart() async {
    if(_product != null) {
      emit(CommonLoadingState());
      _product = _product?.copyWith(addedToCart: true);
      emit(CommonSuccessState<Product>(data: _product!));
    }
  }
}
