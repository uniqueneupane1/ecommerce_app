import 'package:ecommerce_app/features/homepage/cubit/fetch_product_cubit.dart';
import 'package:ecommerce_app/features/homepage/repository/product_repository.dart';
import 'package:ecommerce_app/features/homepage/ui/widgets/homepage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageScreens extends StatelessWidget {
  const HomepageScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchProductsCubit(
        productRepository: context.read<ProductRepository>(),
      )..fetchProducts(),
      child: HomepageWidget(),
    );
  }
}
