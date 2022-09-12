import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/order_provider.dart';

import '../provider/cart.dart' show Cart;
import '../widgets/app_drawer.dart';
import '../widgets/cart_item.dart';

class CartRoute extends StatelessWidget {
  static const String routeName = '/Cart';
  const CartRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItemList = cart.item.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.getQuantity.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false)
                            .addOrder(cartItemList, cart.getQuantity);
                        cart.clearItem();
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: ((context, index) => CartItem(
                id: cartItemList[index].id,
                price: cartItemList[index].price,
                prodectId: cart.item.keys.toList()[index],
                quantity: cartItemList[index].quantity,
                title: cartItemList[index].title)),
            itemCount: cart.item.length,
            //shrinkWrap: true,
          ))
        ],
      ),
    );
  }
}
