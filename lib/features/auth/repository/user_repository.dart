import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/common/services/database_services.dart';
import 'package:ecommerce_app/features/auth/model/user.dart';

class UserRepository {
  final Dio _dio = Dio();
  final DatabaseServices databaseServices = DatabaseServices();

  String _token = "";

  User? _user;

  String get token => _token;

  User? get user => _user;

  Future<void> init() async {
    final _tempToken = await databaseServices.getToken();
    final _tempUser = await databaseServices.getUser();
    if (_tempToken.isNotEmpty && _tempUser != null) {
      _token = _tempToken;
      _user = _tempUser;
    }
  }

  Future<void> logout() async {
    await databaseServices.removeToken();
    await databaseServices.removeUser();

    _token = "";
    _user = null;
  }

  Future<Either<String, void>> login(
      {required String email, required String password}) async {
    try {
      final Map<String, dynamic> payload = {
        "email": email,
        "password": password,
      };
      final response = await _dio.post(
        "${Constants.baseUrl}/auth/login",
        data: payload,
      );
      final String _tempUserToken = response.data["token"];
      final User _tempUser = User.fromMap(response.data["results"]);
      await databaseServices.saveToken(_tempUserToken);
      await databaseServices.saveUser(_tempUser);
      return Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "unable to login");
    } catch (e) {
      return Left("unable to login");
    }
  }
}
