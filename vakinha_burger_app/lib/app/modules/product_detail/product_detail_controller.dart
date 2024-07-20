import 'package:bloc/bloc.dart';

class ProductDetailController extends Cubit<int> {
  late final bool _hasOrderProduct;

  ProductDetailController() : super(1);

  void initial(int amount, bool hasOrderProduct) {
    _hasOrderProduct = hasOrderProduct;
    emit(amount);
  }

  void increment() => emit(state + 1);

  void decrement() {
    if (state > (_hasOrderProduct ? 0 : 1)) {
      emit(state - 1);
    }
  }
}
