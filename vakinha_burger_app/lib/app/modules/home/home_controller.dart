import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dto/order_product_dto.dart';
import '../../repositories/products/products_repository.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProductsRepository productsRepository;

  HomeController(this.productsRepository) : super(const HomeState.initial());

  Future<void> loadProducts() async {
    log('loadProducts');
    emit(state.copyWith(status: HomeStateStatus.loading));

    try {
      final products = await productsRepository.findAllProducts();
      if (products.isRight) {
        emit(state.copyWith(status: HomeStateStatus.loaded, products: products.right));
      } else {
        emit(state.copyWith(status: HomeStateStatus.error, errorMessage: products.left.message));
      }
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s, name: 'HomeController -> loadProducts');
      emit(state.copyWith(status: HomeStateStatus.error, errorMessage: 'Erro ao buscar produtos'));
    }
  }

  void addOrUpdateBag(OrderProductDto orderProduct) {
    final shoppingBag = [...state.shoppingBag];
    final index = shoppingBag.indexWhere((element) => element.product == orderProduct.product);
    if (index > -1) {
      if (orderProduct.amount == 0) {
        shoppingBag.removeAt(index);
      } else {
        shoppingBag[index] = orderProduct;
      }
    } else {
      shoppingBag.add(orderProduct);
    }
    emit(state.copyWith(shoppingBag: shoppingBag));
  }
}
