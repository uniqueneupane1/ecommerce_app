import 'package:dartz/dartz.dart' hide Order;
import 'package:dio/dio.dart';
import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/features/auth/repository/user_repository.dart';
import 'package:ecommerce_app/features/cart/model/cart.dart';
import 'package:ecommerce_app/features/cart/model/initiate_order_param.dart';
import 'package:ecommerce_app/features/cart/model/order.dart';

class CartRepository {
  final UserRepository userRepository;
  final Dio _dio = Dio();

  CartRepository({required this.userRepository});

  List<Cart> _cartItems = [];

  List<Cart> get cartItems => _cartItems;

  Future<Either<String, List<Cart>>> fetchCartItems() async {
    try {
      final res = await _dio.get(
        "${Constants.baseUrl}/cart",
        options: Options(
          headers: {
            "Authorization": "Bearer ${userRepository.token}",
          },
        ),
      );
      final _tempCartItems =
          List.from(res.data["results"]).map((e) => Cart.fromMap(e)).toList();
          _cartItems.clear();
          _cartItems.addAll(_tempCartItems);
      return Right(_tempCartItems);
    } on DioException catch (e) {
      print(e);
      return Left(e.response?.data["message"] ?? "Unable to fetch cart items");
    } catch (e) {
      print(e);
      return Left("Unable to fetch cart items");
    }
  }

  Future<Either<String, Cart>> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      final res = await _dio.put(
        "${Constants.baseUrl}/cart/${cartItemId}",
        data: {
          "quantity": quantity,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${userRepository.token}",
          },
        ),
      );
      final item = Cart.fromMap(res.data["result"]);
      final index = _cartItems.indexWhere((e) => e.id == item.id);
      if(index != -1) {
        _cartItems[index] =item;
      }
      return Right(item);
    } on DioException catch (e) {
      print(e);
      return Left(
          e.response?.data["message"] ?? "Unable to update cart quantity");
    } catch (e) {
      print(e);
      return Left("Unable to update cart quantity");
    }
  }

  Future<Either<String, Order>> initiateOrder ({
    required InitiateOrderParam param,
  }) async {
    try {
      final res = await _dio.post(
        "${Constants.baseUrl}/orders",
        data: param.toMap(),
        options: Options(
          headers: {
            "Authorization": "Bearer ${userRepository.token}",
          },
        ),
      );
      _cartItems.clear();
      final order = Order.fromMap(res.data["results"]);
      return Right(order);
    } on DioException catch (e) {
      print(e);
      return Left(
          e.response?.data["message"] ?? "Unable to initiate order");
    } catch (e) {
      print(e);
      return Left("Unable to initiate order");
    }
  }

  Future<Either<String, void>> completePayment ({
    required String orderId,
    required String refId,
  }) async {
    try {
      final _ = await _dio.post(
        "${Constants.baseUrl}/orders/complete-payment",
        data: {
          "order_id": orderId,
          "ref_id": refId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${userRepository.token}",
          },
        ),
      );
      return Right(null);
    } on DioException catch (e) {
      print(e);
      return Left(
          e.response?.data["message"] ?? "Unable to initiate order");
    } catch (e) {
      print(e);
      return Left("Unable to initiate order");
    }
  }
}
