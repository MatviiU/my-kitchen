import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:my_kitchen/features/products/bloc/add_product/add_product_cubit.dart';
import 'package:my_kitchen/features/products/bloc/add_product/add_product_state.dart';
import 'package:my_kitchen/features/products/bloc/product_bloc.dart';
import 'package:my_kitchen/features/products/presentation/widgets/add_product_widgets/submit_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state.status.isSuccess && state.product != null) {
          context.read<ProductBloc>().add(AddProductEvent(state.product!));
          context.pop();
        }
      },
      builder: (context, state) {
        return Column(
          spacing: 20,
          children: [
            TextField(
              onChanged: (value) =>
                  context.read<AddProductCubit>().nameChanged(value),
              decoration: InputDecoration(
                labelText: 'Назва',
                errorText: state.name.errorMessage,
              ),
            ),
            TextField(
              onChanged: (value) =>
                  context.read<AddProductCubit>().barcodeChanged(value),
              decoration: InputDecoration(
                labelText: 'Штрихкод',
                errorText: state.barcode.errorMessage,
              ),
            ),

            SfDateRangePicker(
              view: DateRangePickerView.month,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                final selectedDate = args.value;
                if (selectedDate is DateTime) {
                  context.read<AddProductCubit>().expirationDateChanged(
                    selectedDate,
                  );
                }
              },
              selectionMode: DateRangePickerSelectionMode.single,
            ),
            if (state.expirationDate.displayError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.expirationDate.errorMessage ?? '',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            TextField(
              onChanged: (value) =>
                  context.read<AddProductCubit>().quantityChanged(value),
              decoration: InputDecoration(
                labelText: 'Кількість',
                errorText: state.quantity.errorMessage,
              ),
            ),
            TextField(
              onChanged: (value) =>
                  context.read<AddProductCubit>().unitChanged(value),
              decoration: InputDecoration(
                labelText: 'Одиниця виміру',
                errorText: state.unit.errorMessage,
              ),
            ),
            const SubmitButton(),
          ],
        );
      },
    );
  }
}
