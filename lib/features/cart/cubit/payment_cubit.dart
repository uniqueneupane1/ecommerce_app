import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/common/extension/dartz_extension.dart';
import 'package:ecommerce_app/features/cart/model/initiate_order_param.dart';
import 'package:ecommerce_app/features/cart/repository/cart_repository.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/common/bloc/common_state.dart';

class PaymentCubit extends Cubit<CommonState> {
  final CartRepository cartRepository;
  PaymentCubit({
    required this.cartRepository,
  }) : super(CommonInitialState());

  initiate({required InitiateOrderParam param}) async {
    try {
      emit(CommonLoadingState());
      final initiatePaymentRes =
          await cartRepository.initiateOrder(param: param);
      if (initiatePaymentRes.isRight()) {
        final order = initiatePaymentRes.asRight();
        //Esewa Payment -------------------------

        EsewaFlutterSdk.initPayment(
          esewaConfig: EsewaConfig(
            environment: Environment.test,
            clientId: Constants.esewaClientId,
            secretId: Constants.esewaSecretKey,
          ),
          esewaPayment: EsewaPayment(
            productId: order.id,
            productName: "Product One",
            productPrice: "20",
            callbackUrl: "",
          ),
          onPaymentSuccess: (EsewaPaymentSuccessResult data) async {
            final paymentRes = await cartRepository.completePayment(
              orderId: order.id,
              refId: data.refId,
            );

            if (paymentRes.isLeft()) {
              emit(CommonErrorState(message: paymentRes.asLeft()));
            } else {
              emit(CommonSuccessState(data: null));
            }
          },
          onPaymentFailure: (data) {
            emit(CommonErrorState(message: data.toString()));
          },
          onPaymentCancellation: (data) {
            emit(CommonErrorState(message: "You have cancelled your order"));
          },
        );
      } else {
        emit(CommonErrorState(message: initiatePaymentRes.asLeft()));
      }
    } catch (e) {
      print(e);
      emit(CommonErrorState(message: "Unable to complete payment"));
    }
  }
}
