import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/prodects_provider.dart';
import 'package:shopapp/widgets/user_product_item.dart';

import '../widgets/app_drawer.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});

  static const routeName = '/user_products';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
                arguments: 'new',
              );
            },
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                  id: productData.items[index].id!,
                  title: productData.items[index].title,
                  imageUrl: productData.items[index].imageUrl),
              const Divider()
            ],
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
