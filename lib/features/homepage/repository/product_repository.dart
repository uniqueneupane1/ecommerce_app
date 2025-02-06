import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/features/auth/repository/user_repository.dart';
import 'package:ecommerce_app/features/homepage/model/products.dart';

class ProductRepository {
  final UserRepository userRepository;
  final Dio _dio = Dio();

  ProductRepository({required this.userRepository});

  Future<Either<String, List<Product>>> fetchProducts() async {
    try {
      final res = await _dio.get(
        "${Constants.baseUrl}/products",
        options: Options(
          headers: {
            "Authorization": "Bearer ${userRepository.token}",
          },
        ),
      );
      final _tempProducts = List.from(res.data["results"])
          .map((e) => Product.fromJson(e))
          .toList();
      return Right(_tempProducts);
    } on DioException catch (e) {
      print(e);
      return Left(e.response?.data["message"] ?? "Unable to fetch products");
    } catch (e) {
      print(e);
      return Left("Unable to fetch products");
    }
  }

  Future<Either<String, Product>> fetchProductDetails(String productId) async {
    try {
      final res = await _dio.get(
        "${Constants.baseUrl}/products/${productId}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${userRepository.token}",
          },
        ),
      );
      final prod = Product.fromJson(res.data["results"]);
      return Right(prod);
    } on DioException catch (e) {
      print(e);
      return Left(e.response?.data["message"] ?? "Unable to fetch products");
    } catch (e) {
      print(e);
      return Left("Unable to fetch products");
    }
  }

  Future<Either<String, void>> addToCart(String productId) async {
    try {
      final _ = await _dio.post(
        "${Constants.baseUrl}/cart",
        data: {
          "product": productId,
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
      return Left(e.response?.data["message"] ?? "Unable to add products in cart");
    } catch (e) {
      print(e);
      return Left("Unable to add products in cart");
    }
  }
}
