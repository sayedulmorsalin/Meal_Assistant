import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddMealDetails extends StatefulWidget {
  final DateTime selectedDate;
  final DailyMealPlan? existingPlan;

  const AddMealDetails({
    super.key,
    required this.selectedDate,
    this.existingPlan,
  });

  @override
  State<AddMealDetails> createState() => _AddMealDetailsState();
}

class _AddMealDetailsState extends State<AddMealDetails> {
  late TextEditingController _breakfastController;
  late TextEditingController _lunchController;
  late TextEditingController _dinnerController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _isEditing = widget.existingPlan?.isEmpty ?? true;
  }

  void _initializeControllers() {
    _breakfastController = TextEditingController(text: widget.existingPlan?.breakfast ?? '');
    _lunchController = TextEditingController(text: widget.existingPlan?.lunch ?? '');
    _dinnerController = TextEditingController(text: widget.existingPlan?.dinner ?? '');
  }

  void _saveMealPlan() {
    final newPlan = DailyMealPlan(
      date: widget.selectedDate,
      breakfast: _breakfastController.text,
      lunch: _lunchController.text,
      dinner: _dinnerController.text,
    );
    Navigator.pop(context, newPlan);
  }

  Widget _buildMealInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(value.isNotEmpty ? value : 'Not specified'),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildEditForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _breakfastController,
            decoration: const InputDecoration(
              labelText: 'Breakfast',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _lunchController,
            decoration: const InputDecoration(
              labelText: 'Lunch',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _dinnerController,
            decoration: const InputDecoration(
              labelText: 'Dinner',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildViewMode() {
    if (widget.existingPlan == null || widget.existingPlan!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No meal plan added',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => _isEditing = true),
              child: const Text('Add Meal Plan'),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMealInfo('Breakfast', widget.existingPlan!.breakfast),
          _buildMealInfo('Lunch', widget.existingPlan!.lunch),
          _buildMealInfo('Dinner', widget.existingPlan!.dinner),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('MMM d, y').format(widget.selectedDate)),
        actions: _isEditing
            ? [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveMealPlan,
          ),
        ]
            : [
          if (widget.existingPlan != null && !widget.existingPlan!.isEmpty)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => _isEditing = true),
            ),
        ],
      ),
      body: _isEditing ? _buildEditForm() : _buildViewMode(),
    );
  }

  @override
  void dispose() {
    _breakfastController.dispose();
    _lunchController.dispose();
    _dinnerController.dispose();
    super.dispose();
  }
}

class DailyMealPlan {
  final DateTime date;
  String breakfast;
  String lunch;
  String dinner;

  DailyMealPlan({
    required this.date,
    this.breakfast = '',
    this.lunch = '',
    this.dinner = '',
  });

  bool get isEmpty => breakfast.isEmpty && lunch.isEmpty && dinner.isEmpty;
}