import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/features/cart/cubit/fetch_cart_item_cubit.dart';
import 'package:ecommerce_app/features/cart/cubit/update_cart_quantity_cubit.dart';
import 'package:ecommerce_app/features/cart/model/cart.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/cart_card.dart';
import 'package:ecommerce_app/features/checkout/ui/screens/check_out_page.dart';
import 'package:ecommerce_app/features/homepage/ui/widgets/product_details_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCartQuantityCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonLoadingState) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }

        if (state is CommonSuccessState) {
          context.read<FetchCartItemsCubit>().updateItems();
          Fluttertoast.showToast(msg: "Cart item updated");
        } else if (state is CommonErrorState) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<FetchCartItemsCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonSuccessState<List<Cart>>) {
                  if (state.data.isNotEmpty) {
                    return ListView.builder(
                      padding: EdgeInsets.only(top: 16),
                      itemBuilder: (context, index) {
                        return CartCard(cart: state.data[index]);
                      },
                      itemCount: state.data.length,
                    );
                  } else {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          "You have no item left in your cart. Please add it via product section !!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                } else if (state is CommonErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return ProductDetailsShimmer();
                }
              },
            ),
          ),
          BlocSelector<FetchCartItemsCubit, CommonState, num>(
            selector: (state) {
              if (state is CommonSuccessState<List<Cart>>) {
                return state.data
                    .fold(0, (pv, e) => pv + (e.quantity * e.product.price));
              } else {
                return 0;
              }
            },
            builder: (context, state) {
              if (state > 0) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1, -3),
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          "Total Cost: Rs. ${state}",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      CustomRoundedButtom(
                        title: "Checkout",
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: BlocProvider.value(
                                value: context.read<FetchCartItemsCubit>(),
                                child: CheckoutPage(),
                              ),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
