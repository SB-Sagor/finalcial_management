import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/u_colors.dart';
import '../../../expenses/screens/add_trip_expense_screen.dart';
import '../../../people/controllers/people_controller.dart';
import 'add_new_employee_screen.dart';

class QuickHubEmployeeScreen extends StatelessWidget {
  const QuickHubEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final controller = Get.put(PeopleController());
    controller.changeTab('employees');
    final List<Map<String, String>> employeesList = [
      {
        'name': 'Rahim Mia',
        'role': 'Truck Driver (Truck #03)',
        'initials': 'RM',
        'advance': '৳১২,০০০',
        'status': 'Present',
      },
      {
        'name': 'Karim Uddin',
        'role': 'Site Loading Helper',
        'initials': 'KU',
        'advance': '৳৩,৫০০',
        'status': 'Present',
      },
      {
        'name': 'Aslam Hossain',
        'role': 'Manager (Gabtoli Point)',
        'initials': 'AH',
        'advance': '৳০',
        'status': 'Absent',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Payroll & Logistics',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => controller.onSearchChanged(value),
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search staff name or role...',
                prefixIcon: const Icon(Iconsax.search_normal, size: 18),
                filled: true,
                fillColor: isLight ? Colors.grey.shade100 : UColors.surfaceDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.filteredPeople.length,
                  // itemCount: employeesList.length,
                  itemBuilder: (context, index) {
                    // final staff = employeesList[index];
                    final staff = controller.filteredPeople[index];
                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: isLight
                              ? Colors.grey.shade200
                              : UColors.borderDark,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundColor: UColors.purple.withValues(
                                  alpha: 0.1,
                                ),
                                child: Text(
                                  staff['initials']?.toString() ?? "EM",
                                  style: const TextStyle(
                                    color: UColors.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    staff['name']?.toString() ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          (staff['status'] ?? 'Present') ==
                                              'Present'
                                          ? UColors.profitGreen.withValues(
                                              alpha: 0.1,
                                            )
                                          : Colors.red.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      staff['status']?.toString() ?? 'Present',
                                      style: TextStyle(
                                        fontSize: 9,
                                        color:
                                            (staff['status'] ?? 'Present') ==
                                                'Present'
                                            ? UColors.profitGreen
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                staff['sub']?.toString() ?? '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Advance Taken',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '৳${(staff['due'] as num?)?.toInt() ?? 0}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: UColors.accentGold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      side: const BorderSide(
                                        color: UColors.accentGold,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Future: Give Advance Sheet
                                    },
                                    icon: const Icon(
                                      Iconsax.money_send,
                                      size: 16,
                                      color: UColors.accentGold,
                                    ),
                                    label: const Text(
                                      'Give Advance',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: UColors.accentGold,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: UColors.purple,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: () => Get.to(
                                      () => const AddTripExpenseScreen(),
                                    ),
                                    icon: const Icon(
                                      Iconsax.truck_fast,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'Log New Trip',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: UColors.profitGreen,
        onPressed: () => Get.to(() => const AddNewEmployeeScreen()),
        icon: const Icon(Iconsax.user_add, color: Colors.white),
        label: const Text(
          'Add New Staff',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
