import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/routes/cart_route.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/badge.dart';

import '../provider/cart.dart';
import '../widgets/product_grid.dart';

enum FiltersOption {
  all,
  onlyfavourite,
}

class PorductoverViewScreen extends StatefulWidget {
  const PorductoverViewScreen({Key? key}) : super(key: key);

  @override
  State<PorductoverViewScreen> createState() => _PorductoverViewScreenState();
}

class _PorductoverViewScreenState extends State<PorductoverViewScreen> {
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FiltersOption value) {
              setState(() {
                if (value == FiltersOption.onlyfavourite) {
                  _isFavourite = true;
                } else {
                  _isFavourite = false;
                }
              });
            },
            itemBuilder: ((_) => [
                  const PopupMenuItem(
                    value: FiltersOption.all,
                    child: Text('All'),
                  ),
                  const PopupMenuItem(
                    value: FiltersOption.onlyfavourite,
                    child: Text('Only Favourite'),
                  ),
                ]),
            child: const Icon(Icons.more_vert),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartRoute.routeName);
              },
              icon: Consumer(
                builder: (context, value, child) => Badge(
                  value: _cart.cartCount.toString(),
                  child: child!,
                ),
                child: const Icon(Icons.shopping_cart),
              ))
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(isFavourite: _isFavourite),
    );
  }
}
