import 'package:ecommerce_app/features/cart/cubit/payment_cubit.dart';
import 'package:ecommerce_app/features/cart/repository/cart_repository.dart';
import 'package:ecommerce_app/features/checkout/ui/widgets/check_out_widget.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(
        cartRepository: context.read<CartRepository>(),
      ),
      child: CheckoutWidgets(),
    );
  }
}
