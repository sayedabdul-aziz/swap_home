import 'package:flutter/material.dart';
import 'package:swap_ui/features/home/data/models/product_model.dart';
import 'package:swap_ui/features/home/presentation/widgets/content/product_list_builder.dart';
import 'package:swap_ui/features/home/presentation/widgets/header/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
                top: 80,
                left: 0,
                right: 0,
                bottom: 90,
                child: ProductListBuilder(
                  model: products[0],
                )),
            const HomeHeader(),
          ],
        ),
      ),
    );
  }
}
