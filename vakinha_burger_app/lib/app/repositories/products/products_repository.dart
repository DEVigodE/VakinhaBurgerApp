import 'package:either_dart/either.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../models/product_model.dart';

abstract class ProductsRepository {
  Future<Either<RepositoryException, List<ProductModel>>> findAllProducts();
}
