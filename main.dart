import 'package:flutter/material.dart';

void main() {
  runApp(const ShoeStoreApp());
}

class ShoeStoreApp extends StatelessWidget {
  const ShoeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ShoeStoreHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ShoeStoreHome extends StatefulWidget {
  const ShoeStoreHome({super.key});

  @override
  State<ShoeStoreHome> createState() => _ShoeStoreHomeState();
}

class _ShoeStoreHomeState extends State<ShoeStoreHome> {
  int _selectedCategory = 0;
  int _cartCount = 0;

  final List<String> _categories = [
    'All',
    'Running',
    'Basketball',
    'Casual',
    'Sneakers'
  ];

  final List<Map<String, dynamic>> _shoes = [
    {
      'name': 'Nike Air Max',
      'price': '\$120',
      'category': 'Running',
      'image': '🟠',
      'color': Colors.orange[100],
      'isFavorite': false,
    },
    {
      'name': 'Adidas Ultraboost',
      'price': '\$150',
      'category': 'Running',
      'image': '🔵',
      'color': Colors.blue[100],
      'isFavorite': true,
    },
    {
      'name': 'Jordan 1',
      'price': '\$180',
      'category': 'Basketball',
      'image': '🔴',
      'color': Colors.red[100],
      'isFavorite': false,
    },
    {
      'name': 'Converse Chuck',
      'price': '\$60',
      'category': 'Casual',
      'image': '⚫',
      'color': Colors.grey[300],
      'isFavorite': false,
    },
    {
      'name': 'Vans Old Skool',
      'price': '\$70',
      'category': 'Sneakers',
      'image': '⬛',
      'color': Colors.black12,
      'isFavorite': true,
    },
    {
      'name': 'New Balance 550',
      'price': '\$110',
      'category': 'Sneakers',
      'image': '⚪',
      'color': Colors.grey[100],
      'isFavorite': false,
    },
  ];

  void _addToCart() {
    setState(() {
      _cartCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to cart!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _toggleFavorite(int index) {
    setState(() {
      _shoes[index]['isFavorite'] = !_shoes[index]['isFavorite'];
    });
  }

  List<Map<String, dynamic>> get _filteredShoes {
    if (_selectedCategory == 0) return _shoes;
    return _shoes
        .where((shoe) => shoe['category'] == _categories[_selectedCategory])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shoe Store',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {},
              ),
              if (_cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.lightBlue],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SUMMER SALE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Up to 50% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.local_offer_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? 16 : 8,
                    right: index == _categories.length - 1 ? 16 : 8,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = index;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedCategory == index
                          ? Colors.blue
                          : Colors.grey[200],
                      foregroundColor: _selectedCategory == index
                          ? Colors.white
                          : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(_categories[index]),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: _filteredShoes.length,
                itemBuilder: (context, index) {
                  final shoe = _filteredShoes[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: shoe['color'],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  shoe['image'],
                                  style: const TextStyle(fontSize: 40),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: Icon(
                                    shoe['isFavorite']
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: shoe['isFavorite'] ? Colors.red : Colors.grey,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    final mainIndex = _shoes.indexWhere(
                                        (s) => s['name'] == shoe['name']);
                                    if (mainIndex != -1) {
                                      _toggleFavorite(mainIndex);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shoe['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                shoe['category'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    shoe['price'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: _addToCart,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}