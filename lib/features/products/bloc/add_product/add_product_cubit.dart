import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:my_kitchen/features/products/bloc/add_product/add_product_state.dart';
import 'package:my_kitchen/features/products/bloc/add_product/inputs/barcode_inpute.dart';
import 'package:my_kitchen/features/products/bloc/add_product/inputs/expiration_date_input.dart';
import 'package:my_kitchen/features/products/bloc/add_product/inputs/name_input.dart';
import 'package:my_kitchen/features/products/bloc/add_product/inputs/quantity_input.dart';
import 'package:my_kitchen/features/products/bloc/add_product/inputs/unit_input.dart';
import 'package:my_kitchen/features/products/data/sqlite_products_repository.dart';
import 'package:my_kitchen/features/products/domain/product_model.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(const AddProductState());

  final _repository = SqliteProductsRepository();

  void nameChanged(String value) {
    final name = NameInput.dirty(value: value);
    emit(state.copyWith(name: name));
  }

  void barcodeChanged(String value) {
    final barcode = BarcodeInput.dirty(value: value);
    emit(state.copyWith(barcode: barcode));
  }

  void expirationDateChanged(DateTime? date) {
    final expirationDate = ExpirationDateInput.dirty(date);
    emit(state.copyWith(expirationDate: expirationDate));
  }

  void quantityChanged(String value) {
    final quantity = QuantityInput.dirty(value: value);
    emit(state.copyWith(quantity: quantity));
  }

  void unitChanged(String value) {
    final unit = UnitInput.dirty(value: value);
    emit(state.copyWith(unit: unit));
  }

  Future<void> submit() async {
    final name = NameInput.dirty(value: state.name.value);
    final barcode = BarcodeInput.dirty(value: state.barcode.value);
    final expirationDate = ExpirationDateInput.dirty(
      state.expirationDate.value,
    );
    final quantity = QuantityInput.dirty(value: state.quantity.value);
    final unit = UnitInput.dirty(value: state.unit.value);

    final isValid = Formz.validate([
      name,
      barcode,
      expirationDate,
      quantity,
      unit,
    ]);

    if (!isValid) {
      emit(
        state.copyWith(
          name: name,
          barcode: barcode,
          expirationDate: expirationDate,
          quantity: quantity,
          unit: unit,
          status: FormzSubmissionStatus.failure,
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final product = ProductModel(
      name: name.value,
      barcode: barcode.value,
      addedDate: DateTime.now().toIso8601String(),
      expirationDate: expirationDate.value?.toIso8601String() ?? '',
      quantity: double.parse(quantity.value),
      unit: unit.value,
    );

    try {
      await _repository.insertProduct(product);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }

    emit(
      state.copyWith(
        name: name,
        barcode: barcode,
        expirationDate: expirationDate,
        quantity: quantity,
        unit: unit,
        status: isValid
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
        product: product,
      ),
    );
  }
}
