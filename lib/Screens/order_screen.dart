import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/order_provider.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/Order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Order')),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: ((context, index) =>
            OrderItem(order: order.orders[index])),
        itemCount: order.orders.length,
      ),
    );
  }
}
