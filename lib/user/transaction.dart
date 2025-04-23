import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum ActivityType { request, approval }

class TransactionActivity {
  final String userName;
  final ActivityType type;
  final DateTime date;
  final String status;

  TransactionActivity({
    required this.userName,
    required this.type,
    required this.date,
    required this.status,
  });
}

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final List<TransactionActivity> activities = [
    TransactionActivity(
      userName: 'Morsalin',
      type: ActivityType.request,
      date: DateTime(2025, 3, 24),
      status: 'Pending',
    ),
    TransactionActivity(
      userName: 'Manager',
      type: ActivityType.approval,
      date: DateTime(2025, 3, 24),
      status: 'Accepted',
    ),
    TransactionActivity(
      userName: 'Alice',
      type: ActivityType.request,
      date: DateTime(2025, 3, 25),
      status: 'Rejected',
    ),
  ];

  String _getActionText(TransactionActivity activity) {
    if (activity.type == ActivityType.request) {
      return '${activity.userName} requested to turn on meal';
    } else {
      return '${activity.userName} ${activity.status.toLowerCase()} the request';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: activities.length,
          separatorBuilder: (context, index) => const Divider(height: 32),
          itemBuilder: (context, index) {
            final activity = activities[index];
            return ListTile(
              leading: Icon(
                activity.type == ActivityType.request
                    ? Icons.notification_important
                    : Icons.verified_user,
                color: _getStatusColor(activity.status),
                size: 32,
              ),
              title: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: _getActionText(activity),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: '\n${DateFormat('dd/MM/yyyy HH:mm').format(activity.date)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Chip(
                label: Text(
                  activity.status,
                  style: TextStyle(
                    color: _getStatusColor(activity.status).computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                backgroundColor: _getStatusColor(activity.status),
              ),
            );
          },
        ),
      ),
    );
  }
}