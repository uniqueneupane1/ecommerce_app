import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/custom_network_image.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/features/homepage/cubit/add_product_in_cart_cubit.dart';
import 'package:ecommerce_app/features/homepage/cubit/fetch_product_details_cubit.dart';
import 'package:ecommerce_app/features/homepage/model/products.dart';
import 'package:ecommerce_app/features/homepage/ui/widgets/product_details_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ProductDetailsWidgets extends StatelessWidget {
  final String productId;
  ProductDetailsWidgets({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backGroundColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.primaryColor,
      ),
      body: BlocListener<AddProductInCartCubit, CommonState>(
        listener: (context, state) {
          if(state is CommonLoadingState) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if(state is CommonSuccessState) {
            context.read<FetchProductDetailsCubit>().addedInCart();
            Fluttertoast.showToast(msg: "Product added to cart");
          } else if(state is CommonErrorState) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        child: BlocBuilder<FetchProductDetailsCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonSuccessState<Product>) {
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .35,
                    width: double.infinity,
                    child: CustomNetworkImage(
                      imageUrl: state.data.image,
                      height: double.infinity,
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 40, right: 14, left: 14),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          height: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.data.brand,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.data.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Text(
                                      'Rs. ${state.data.price}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  state.data.description,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: CustomTheme.darkGrayColor,
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: CustomTheme.gray,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
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
      bottomNavigationBar:
          BlocSelector<FetchProductDetailsCubit, CommonState, bool>(
        selector: (state) {
          if (state is CommonSuccessState<Product>) {
            return !state.data.addedToCart;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state) {
            return Container(
              height: 70,
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: CustomRoundedButtom(
                title: "+ Add to Cart",
                onPressed: () {
                  context.read<AddProductInCartCubit>().add(productId);
                },
              ),
            );
          } else {
            return Container(height: 1);
          }
        },
      ),
    );
  }
}
