import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/textfield/custom_textfield.dart';
import 'package:ecommerce_app/features/auth/repository/user_repository.dart';
import 'package:ecommerce_app/features/cart/cubit/fetch_cart_item_cubit.dart';
import 'package:ecommerce_app/features/cart/cubit/payment_cubit.dart';
import 'package:ecommerce_app/features/cart/model/initiate_order_param.dart';
import 'package:ecommerce_app/features/checkout/ui/widgets/order_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CheckoutWidgets extends StatefulWidget {
  const CheckoutWidgets({super.key});

  @override
  State<CheckoutWidgets> createState() => _CheckoutWidgetsState();
}

class _CheckoutWidgetsState extends State<CheckoutWidgets> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = context.read<UserRepository>().user;
    if (user != null) {
      _fullNameController.text = user.name;
      _phoneNoController.text = user.phone;
      _addressController.text = user.address;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.primaryColor,
        title: Text(
          "Checkout",
          style: GoogleFonts.poppins(
            fontSize: 16,
          ),
        ),
      ),
      body: BlocListener<PaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoadingState) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }

          if (state is CommonSuccessState) {
            context.read<FetchCartItemsCubit>().updateItems();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return OrderConfirmDialog();
              },
            );
          } else if (state is CommonErrorState) {
            context.read<FetchCartItemsCubit>().updateItems();
            Fluttertoast.showToast(msg: state.message);
          }
        },
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CustomTextField(
                    label: "Full Name",
                    controller: _fullNameController,
                    hintText: "Full Name",
                    fieldName: "full_name",
                  ),
                  CustomTextField(
                    label: "Phone Number",
                    controller: _phoneNoController,
                    hintText: "Phone Number",
                    fieldName: "phone_number",
                  ),
                  CustomTextField(
                    label: "City",
                    controller: _cityController,
                    hintText: "City",
                    fieldName: "city",
                  ),
                  CustomTextField(
                    label: "Address",
                    controller: _addressController,
                    hintText: "Address",
                    fieldName: "address",
                  ),
                  CustomRoundedButtom(
                    title: "Confirm Order",
                    onPressed: () {
                      final param = InitiateOrderParam(
                        fullName: _fullNameController.text,
                        phoneNo: _phoneNoController.text,
                        city: _cityController.text,
                        address: _addressController.text,
                      );
                      context.read<PaymentCubit>().initiate(
                            param: param,
                          );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
