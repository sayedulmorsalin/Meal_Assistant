import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductItem {
  final String productName;
  final int quantity;
  final double price;

  ProductItem(this.productName, this.quantity, this.price);
}

class ShoppingTable {
  final DateTime date;
  final List<ProductItem> items;

  ShoppingTable(this.date, this.items);
}

class AddShopping extends StatefulWidget {
  const AddShopping({super.key});

  @override
  State<AddShopping> createState() => _AddShoppingState();
}

class _AddShoppingState extends State<AddShopping> {
  final List<ShoppingTable> _tables = [];

  void _addItem(String productName, int quantity, double price) {
    final now = DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);

    setState(() {
      final existingTableIndex = _tables.indexWhere(
        (table) => table.date.isAtSameMomentAs(currentDate),
      );

      if (existingTableIndex != -1) {
        _tables[existingTableIndex].items.add(
          ProductItem(productName, quantity, price),
        );
      } else {
        _tables.add(
          ShoppingTable(currentDate, [
            ProductItem(productName, quantity, price),
          ]),
        );
      }
    });
  }

  void _showAddItemDialog() {
    final productNameController = TextEditingController();
    final quantityController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Item'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: productNameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final productName = productNameController.text;
                  final quantity = int.tryParse(quantityController.text) ?? 0;
                  final price = double.tryParse(priceController.text) ?? 0.0;

                  if (productName.isNotEmpty && quantity > 0 && price > 0) {
                    _addItem(productName, quantity, price);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter valid values for all fields',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Records')),
      body:
          _tables.isEmpty
              ? const Center(child: Text('No items added yet'))
              : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _tables.length,
                itemBuilder: (context, index) {
                  final table = _tables[index];
                  final total = table.items.fold(
                    0.0,
                    (sum, item) => sum +  item.price,
                  );

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('yyyy-MM-dd').format(table.date),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Product')),
                                DataColumn(label: Text('Qty')),
                                DataColumn(label: Text('Price')),
                              ],
                              rows:
                                  table.items.map((item) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(item.productName)),
                                        DataCell(
                                          Text(item.quantity.toString()),
                                        ),
                                        DataCell(
                                          Text(item.price.toStringAsFixed(2)),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Total: ${total.toStringAsFixed(2)} Taka',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
