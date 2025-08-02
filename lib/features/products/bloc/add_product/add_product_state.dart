import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:my_kitchen/features/products/bloc/add_product/inputs/barcode_inpute.dart';
import 'package:my_kitchen/features/products/bloc/add_product/inputs/expiration_date_input.dart';
import 'package:my_kitchen/features/products/bloc/add_product/inputs/name_input.dart';
import 'package:my_kitchen/features/products/bloc/add_product/inputs/quantity_input.dart';
import 'package:my_kitchen/features/products/bloc/add_product/inputs/unit_input.dart';
import 'package:my_kitchen/features/products/domain/product_model.dart';

class AddProductState extends Equatable {
  const AddProductState({
    this.name = const NameInput.pure(),
    this.barcode = const BarcodeInput.pure(),
    this.expirationDate = const ExpirationDateInput.pure(),
    this.quantity = const QuantityInput.pure(),
    this.unit = const UnitInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
    this.product,
  });

  final NameInput name;
  final BarcodeInput barcode;
  final ExpirationDateInput expirationDate;
  final QuantityInput quantity;
  final UnitInput unit;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  final ProductModel? product;

  bool get isValid =>
      name.isValid &&
      barcode.isValid &&
      expirationDate.isValid &&
      quantity.isValid &&
      unit.isValid;

  AddProductState copyWith({
    NameInput? name,
    BarcodeInput? barcode,
    ExpirationDateInput? expirationDate,
    QuantityInput? quantity,
    UnitInput? unit,
    FormzSubmissionStatus? status,
    String? errorMessage,
    ProductModel? product,
  }) {
    return AddProductState(
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      expirationDate: expirationDate ?? this.expirationDate,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      product: product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [
    name,
    barcode,
    expirationDate,
    quantity,
    unit,
    status,
    errorMessage,
    product,
  ];
}
