import 'package:flutter/material.dart';
import 'api_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    List productList = await ApiService.fetchProducts();
    setState(() {
      products = productList;
    });
  }

  void deleteProduct(String id) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ยืนยันการลบ'),
        content: Text('คุณต้องการลบสินค้านี้ใช่หรือไม่?'),
        actions: [
          TextButton(
            child: Text('ยกเลิก'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text('ลบ'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      try {
        await ApiService.deleteProduct(id);
        setState(() {
          products.removeWhere((product) => product['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ลบสินค้าเรียบร้อย'),
            backgroundColor: Colors.green, 
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ไม่สามารถลบสินค้าได้'),
            backgroundColor: const Color.fromARGB(255, 209, 32, 32), 
          ),
        );
      }
    }
  }

  void addProduct() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    bool? confirmAdd = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('เพิ่มสินค้าใหม่'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'ชื่อสินค้า'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'รายละเอียด'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'ราคา'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('ยกเลิก'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text('เพิ่ม'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmAdd == true) {
      await ApiService.addProduct(
        nameController.text,
        descriptionController.text,
        double.tryParse(priceController.text) ?? 0.0,
      );
      fetchProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('เพิ่มสินค้าเรียบร้อย'),
          backgroundColor: Colors.green, 
        ),
      );
    }
  }

  void updateProduct(String id) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    final product = products.firstWhere((product) => product['id'] == id);
    nameController.text = product['name'];
    descriptionController.text = product['description'];
    priceController.text = product['price'].toString();

    bool? confirmUpdate = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('แก้ไขสินค้า'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'ชื่อสินค้า'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'รายละเอียด'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'ราคา'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('ยกเลิก'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text('อัปเดต'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmUpdate == true) {
      await ApiService.updateProduct(
        id,
        nameController.text,
        descriptionController.text,
        double.tryParse(priceController.text) ?? 0.0,
      );
      fetchProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('อัปเดตสินค้าเรียบร้อย'),
          backgroundColor: Colors.green, 
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Products"),
          backgroundColor: const Color.fromARGB(255, 147, 201, 242)),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(product['name']),
              subtitle: Text(product['description']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '฿ ${product['price'].toStringAsFixed(1)}',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: const Color.fromARGB(255, 118, 130, 140)),
                    onPressed: () => updateProduct(product['id']),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteProduct(product['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        backgroundColor: const Color.fromARGB(255, 165, 204, 255),
        child: Icon(Icons.add),
      ),
    );
  }
}
