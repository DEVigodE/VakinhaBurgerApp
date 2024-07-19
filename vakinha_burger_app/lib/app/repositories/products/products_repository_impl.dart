import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import '../../core/custom_dio/custom_dio.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/ui/helpers/httpcode.dart';
import '../../models/product_model.dart';
import './products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final CustomDio restClient;

  ProductsRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, List<ProductModel>>> findAllProducts() async {
    try {
      final Response(:List data) = await restClient.unAuth.get('/products');

      final List<ProductModel> products = (data).map((hospitalData) {
        return ProductModel.fromJson(hospitalData); // Supondo que você tenha um método para converter os dados do médico para um objeto Hospital
      }).toList();

      return Right(products);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(RepositoryException(message: e.getHttpStatusDescription));
      } else if (e.response?.statusCode == 401) {
        return Left(RepositoryException(message: e.getHttpStatusDescription));
      } else {
        return Left(RepositoryException(message: e.getHttpStatusDescription));
      }
    } on Exception catch (e) {
      return Left(RepositoryException(message: e.toString()));
    }
  }
}
