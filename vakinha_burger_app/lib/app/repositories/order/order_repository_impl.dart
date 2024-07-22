import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/custom_dio/custom_dio.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../dto/order_dto.dart';
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

  @override
  Future<void> createOrder(OrderDto order) async {
    try {
      await dio.auth.post(
        '/orders',
        data: {
          'products': order.products
              .map(
                (e) => {
                  'id': e.product.id,
                  'amount': e.amount,
                  'total_price': e.total,
                },
              )
              .toList(),
          'user_id':
              '#userAuthRef', //BACKEND do JSON_REST_SERVER não suporta essa funcionalidade de id do usuário autenticado, por isso foi colocado essa tag
          'address': order.addresss,
          'CPF': order.document,
          'payment_method_id': order.paymentTypeId,
        },
      );
    } on DioException catch (e, s) {
      log('LOG: Erro ao criar pedido', error: e, stackTrace: s, name: 'OrderRepositoryImpl');
      throw RepositoryException(message: 'Erro ao criar pedido');
    }
  }
}
