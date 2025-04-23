import 'package:flutter/material.dart';

class Member {
  final String name;
  final double totalDeposit;
  final int totalMeal;
  final double availableBalance;

  Member({
    required this.name,
    required this.totalDeposit,
    required this.totalMeal,
    required this.availableBalance,
  });
}

class MealMember extends StatefulWidget {
  const MealMember({super.key});

  @override
  State<MealMember> createState() => _MealMemberState();
}

class _MealMemberState extends State<MealMember> {
  final List<Member> members = [
    Member(
      name: 'John Doe',
      totalDeposit: 1500.0,
      totalMeal: 30,
      availableBalance: 500.0,
    ),
    Member(
      name: 'Jane Smith',
      totalDeposit: 2000.0,
      totalMeal: 45,
      availableBalance: 750.0,
    ),
    Member(
      name: 'Mike Johnson',
      totalDeposit: 1800.0,
      totalMeal: 35,
      availableBalance: 600.0,
    ),
  ];

  void _addDeposit(Member member) {
    // Implement deposit logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Add deposit for ${member.name}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Members'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                member.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Deposit: \$${member.totalDeposit.toString()}'),
                      Text('Total Meal: ${member.totalMeal.toString()}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Available Balance: \$${member.availableBalance.toString()}',
                    style: TextStyle(
                      color: member.availableBalance >= 0
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.blue),
                onPressed: () => _addDeposit(member),
              ),
            ),
          );
        },
      ),
    );
  }
}