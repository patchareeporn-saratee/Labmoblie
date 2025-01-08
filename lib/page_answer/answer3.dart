import 'package:flutter/material.dart';

class Answer3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Product Layout',
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.orange,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Container(
              width: double.infinity,
              color: Colors.grey[300],
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Category: Electronics',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            // Product Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 25,
                crossAxisSpacing: 16,
                padding: const EdgeInsets.all(16.0),
                children: const [
                  ProductCard(
                    imageUrl: 'assets/images/1.png',
                    name: 'Laptop"',
                    price: '999 THB',
                  ),
                  ProductCard(
                    imageUrl: 'assets/images/2.png',
                    name: 'Smartphone',
                    price: '699',
                  ),
                  ProductCard(
                    imageUrl: 'assets/images/3.png',
                    name: 'Tablet',
                    price: '499 THB',
                  ),
                  ProductCard(
                    imageUrl: 'assets/images/4.png',
                    name: 'Camara',
                    price: '299 THB',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // ปุ่มกลับไปหน้าหลัก
          ],
        ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imageUrl,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          price,
          style: const TextStyle(color: Colors.green),
        ),
      ],
    );
  }
}