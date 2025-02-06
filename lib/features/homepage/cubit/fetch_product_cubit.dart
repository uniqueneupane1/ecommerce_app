// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/features/homepage/model/products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/homepage/repository/product_repository.dart';

class FetchProductsCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  FetchProductsCubit({
    required this.productRepository,
  }) : super(CommonInitialState());

  fetchProducts() async {
    emit(CommonLoadingState());
    final res = await productRepository.fetchProducts();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<List<Product>>(data: data)),
    );
  }
}
