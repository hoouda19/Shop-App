import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/order_provider.dart';
import 'package:shopapp/routes/cart_route.dart';
import 'package:shopapp/routes/order_screen.dart';

import './routes/product_over_view_screen.dart';
import 'provider/cart.dart';
import 'provider/prodects_provider.dart';
import 'routes/product_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'lato'),
        home: const PorductoverViewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartRoute.routeName: (context) => CartRoute(),
          OrderScreen.routeName: (context) => OrderScreen(),
        },
      ),
    );
  }
}
