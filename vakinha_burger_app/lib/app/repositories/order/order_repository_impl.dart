import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/custom_dio/custom_dio.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../models/payment_type_model.dart';
import './order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final CustomDio dio;

  OrderRepositoryImpl({required this.dio});

  @override
  Future<List<PaymentTypeModel>> getAllPaymentTypes() async {
    try {
      final result = await dio.auth.get('/payment-types');
      return result.data.map<PaymentTypeModel>((e) => PaymentTypeModel.fromMap(e)).toList();
    } on DioException catch (e, s) {
      log('LOG: Erro ao buscar formas de pagamento', error: e, stackTrace: s, name: 'OrderRepositoryImpl');
      throw RepositoryException(message: 'Erro ao buscar formas de pagamento');
    }
  }
}
