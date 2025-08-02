import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_kitchen/features/products/bloc/product_bloc.dart';
import 'package:my_kitchen/features/scanner/bloc/scanner_bloc.dart';
import 'package:my_kitchen/features/scanner/presentation/widgets/scanner_viewfinder.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  var _isScanned = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScannerBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(24),
            child: Text('Сканувати штрихкод'),
          ),
        ),
        body: BlocConsumer<ScannerBloc, ScannerState>(
          listener: (context, state) {
            if (state is ScannerSuccess || state is ScannerFailure) {
              _isScanned = false;
            }
            if (state is ScannerSuccess) {
              final product = state.product;
              context.read<ProductBloc>().add(AddScannedProduct(product));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
              if (context.mounted) context.pop();
            } else if (state is ScannerFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                ScannerViewfinder(
                  isScanned: _isScanned,
                  onBarcodeDetected: (barcode) {
                    setState(() {
                      _isScanned = true;
                    });
                    context.read<ScannerBloc>().add(BarcodeScanned(barcode));
                  },
                ),
                if (state is ScannerLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}
