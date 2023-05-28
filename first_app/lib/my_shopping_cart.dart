import 'package:flutter/material.dart';

class Product {
  final String name;
  Product({required this.name});
}

typedef ChangeProductInCart = Function(Product product, bool inCart);

class ShoppingItem extends StatelessWidget {
  final Product product;
  final bool inCart;
  final ChangeProductInCart onCartChanged;

  const ShoppingItem(
      {super.key,
      required this.inCart,
      required this.onCartChanged,
      required this.product});

  TextStyle? _getTextStyle(BuildContext context) {
    if (inCart == false) {
      return null;
    } else {
      return const TextStyle(
          decoration: TextDecoration.lineThrough, color: Colors.black54);
    }
  }

  Color? _getBackgroundColour(BuildContext context) {
    if (inCart == false) {
      return Theme.of(context).primaryColor;
    } else {
      return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onCartChanged(product, inCart),
      leading: CircleAvatar(
        backgroundColor: _getBackgroundColour(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class ShoppingList extends StatefulWidget {
  final List<Product> products;
  const ShoppingList({super.key, required this.products});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _cartItems = <Product>{};

  void _handleClick(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _cartItems.remove(product);
      } else {
        _cartItems.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Shopping List")),
        body: ListView(
            children: widget.products.map((product) {
          return ShoppingItem(
              product: product,
              inCart: _cartItems.contains(product),
              onCartChanged: _handleClick);
        }).toList()));
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Shopping App',
    home: ShoppingList(
      products: [
        Product(name: 'Eggs'),
        Product(name: 'Flour'),
        Product(name: 'Chocolate chips'),
      ],
    ),
  ));
}
