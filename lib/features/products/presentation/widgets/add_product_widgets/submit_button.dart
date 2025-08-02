import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kitchen/features/products/bloc/add_product/add_product_cubit.dart';
import 'package:my_kitchen/features/products/bloc/add_product/add_product_state.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      buildWhen: (previous, current) => current.status != previous.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isValid
              ? () {
            context.read<AddProductCubit>().submit();
          }
              : null,
          child: const Text('Додати продукт'),
        );
      },
    );
  }
}
