import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;

class ProductsGrid extends StatelessWidget {
  List<Map<String, Object>> products = [
    {
      'name': 'El-Ezzaby',
      'price': 35,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKuJkWPaK1aw1myxbR00UQNPB48LmW-YL-smxEYbMy28WGTpC9&s'
    },
    {
      'name': 'El-Ezzaby',
      'price': 35,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKuJkWPaK1aw1myxbR00UQNPB48LmW-YL-smxEYbMy28WGTpC9&s'
    },
    {
      'name': 'El-Ezzaby',
      'price': 35,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKuJkWPaK1aw1myxbR00UQNPB48LmW-YL-smxEYbMy28WGTpC9&s'
    }
  ];

  Future<Map<String, Object>> extractData(
      Map<String, Object> pharmaciesName) async {
    DocumentSnapshot pharmacy = await Firestore.instance
        .collection('Pharmacies')
        .document(pharmaciesName['id'])
        .get();
    print('A' + pharmacy.data.toString());
    return {'pharmacy': pharmacy.data, 'price': pharmaciesName['price']};
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Object> drug =
        (ModalRoute.of(context).settings.arguments as Map<String, Object>);
    print(drug);
    List<Map<String, Object>> pharmaciesName =
        (drug['pharm'] as List<dynamic>).map((item) {
      return {'id': item['id'], 'price': item['price']};
    }).toList();
    print(pharmaciesName);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: pharmaciesName.length,
      itemBuilder: (ctx, i) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FutureBuilder<Map<String, Object>>(
          future: extractData(pharmaciesName[i]),
          builder: (context, data) {
            print(data.data);
            if (data.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );

            return GridTile(
              child: Image.network(
                (data.data['pharmacy'] as Map<String, Object>)['image'],
                fit: BoxFit.fitWidth,
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(
                  (data.data['pharmacy'] as Map<String, Object>)['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                leading: Text(
                  '${data.data['price']}\$',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.left,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false).addItem(
                        '${pharmaciesName[i]['id']}:${drug['name']}',
                        ((data.data['price'] as int) + 0.0),
                        drug['name'],
                        pharmaciesName[i]['id'],
                        (data.data['pharmacy'] as Map<String, Object>)['name']);
                    print(
                        (data.data['pharmacy'] as Map<String, Object>)['name']);
                    print(
                        'ITEMSS:${Provider.of<Cart>(context, listen: false).items}');
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Added item to cart!',
                        ),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                  color: Theme.of(context).accentColor,
                ),
              ),
            );
          },
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }

  Widget pharmaciesList(context, pharmaceis) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: pharmaceis.length,
      itemBuilder: (ctx, i) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: Image.network(
              (pharmaceis[i]['pharmacy'] as Map<String, Object>)['image']),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              (pharmaceis[i]['pharmacy'] as Map<String, Object>)['name'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            leading: Text(
              '${pharmaceis[i]['price']}\$',
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.left,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added item to cart!',
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {},
                    ),
                  ),
                );
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
