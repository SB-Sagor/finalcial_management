import 'package:finalcial_management/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:finalcial_management/custom_widgets/option_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> options = [
    {"name": "Add Payments", "onTap": () => print("Payments tapped")},
    {"name": "Add Expenses", "onTap": () => print("Expenses tapped")},
    {"name": "Clients", "onTap": () => print("Clients tapped")},
    {"name": "Employees", "onTap": () => print("Employees tapped")},
    {"name": "Transactions", "onTap": () => print("Transactions tapped")},
    {"name": "Reports", "onTap": () => print("Reports tapped")},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Business Dashboard",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Icon(
              Provider.of<ThemeProvider>(context).isLightMode
                  ? Icons.wb_sunny_sharp
                  : Icons.nightlight_sharp,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Main Balance card
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.colorScheme.secondaryContainer,
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Main Balance',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ),

          // Income/Expense/Profit row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: OptionCard(
                    onTap: () {},
                    name: "Incomes\n5000 tk",
                    icon: Icons.trending_up,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OptionCard(
                    onTap: () {},
                    name: "Expenses\n25000 tk",
                    icon: Icons.trending_down,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OptionCard(
                    onTap: () {},
                    name: "Profits\n25000 tk",
                    icon: Icons.attach_money,
                  ),
                ),
              ],
            ),
          ),

          // Total Due card
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.colorScheme.errorContainer,
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Total Due',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
            ),
          ),

          // Grid options
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: options.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                return OptionCard(
                  onTap: options[index]["onTap"],
                  name: options[index]["name"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
