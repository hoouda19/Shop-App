import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopapp/provider/product.dart';
import '../provider/prodects_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName = '/edit_product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFoucsNode = FocusNode();
  final _descriptionFoucsNode = FocusNode();
  final imageUrlController = TextEditingController();
  final imageUrlFoucsNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  Product editedProduct = Product(
    id: null,
    description: '',
    imageUrl: '',
    price: 0.0,
    title: '',
  );
  bool _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'imageUrl': '',
    'price': '',
  };

  @override
  void initState() {
    imageUrlFoucsNode.addListener(updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      String productId = ModalRoute.of(context)!.settings.arguments as String;
      print('up');
      if (productId != 'new') {
        print('dwon');
        editedProduct = Provider.of<Products>(context).findById(productId);
        _initValues = {
          'title': editedProduct.title,
          'description': editedProduct.description,
          'imageUrl': '',
          'price': editedProduct.price.toString(),
        };
        imageUrlController.text = editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    imageUrlFoucsNode.removeListener(updateImageUrl);
    imageUrlFoucsNode.dispose();
    _priceFoucsNode.dispose();
    _descriptionFoucsNode.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  void updateImageUrl() {
    setState(() {});
    if (!imageUrlFoucsNode.hasFocus) {
      if (!imageUrlController.text.startsWith('http') &&
          !imageUrlController.text.startsWith('https')) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    if (editedProduct.id != null) {
      Provider.of<Products>(context, listen: false).addProduct(editedProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Screen'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter a title';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFoucsNode),
                  onSaved: (value) {
                    editedProduct = Product(
                        id: editedProduct.id,
                        description: editedProduct.description,
                        imageUrl: editedProduct.imageUrl,
                        price: editedProduct.price,
                        title: value!);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFoucsNode,
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionFoucsNode),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter a price';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return 'invaild price';
                    }
                  },
                  onSaved: (value) {
                    editedProduct = Product(
                        id: editedProduct.id,
                        description: editedProduct.description,
                        imageUrl: editedProduct.imageUrl,
                        price: double.parse(value!),
                        title: editedProduct.title);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFoucsNode,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'enter a description';
                    }
                    if (value.length < 10) {
                      return 'shoud be at least 10 characters long';
                    }
                  }),
                  onSaved: (value) {
                    editedProduct = Product(
                        id: editedProduct.id,
                        description: value!,
                        imageUrl: editedProduct.imageUrl,
                        price: editedProduct.price,
                        title: editedProduct.title);
                  },
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: imageUrlController.text.isEmpty
                            ? const Text('Enter a URL')
                            : Image.network(imageUrlController.text),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: imageUrlController,
                      focusNode: imageUrlFoucsNode,
                      onEditingComplete: () {
                        setState(() {});
                        _saveForm();
                      },
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'enter a Image Url';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'invaild';
                        }
                      }),
                      onSaved: (value) {
                        editedProduct = Product(
                            id: editedProduct.id,
                            description: editedProduct.description,
                            imageUrl: value!,
                            price: editedProduct.price,
                            title: editedProduct.title);
                      },
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
