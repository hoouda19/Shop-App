import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {Key? key,
      required this.id,
      required this.prodectId,
      required this.price,
      required this.quantity,
      required this.title})
      : super(key: key);
  final String id;
  final String prodectId;
  final double price;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text('Are You Sure?'),
              content: const Text('Are You Sure Do You Want To Remove Item'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No')),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes')),
              ],
            )),
      ),
      onDismissed: (direction) => cart.deleteItem(prodectId),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('\$$price'),
              ),
            )),
            title: Text(title),
            subtitle: Text('\$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
