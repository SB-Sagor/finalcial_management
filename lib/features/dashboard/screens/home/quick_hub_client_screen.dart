import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/u_colors.dart';
import '../../../bills/screens/create_invoice_screen.dart';
import '../../../people/controllers/people_controller.dart';
import 'add_new_client_screen.dart';

class QuickHubClientScreen extends StatelessWidget {
  const QuickHubClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final controller = Get.put(PeopleController());
    controller.changeTab('clients');

    // Dummy Real-world Data for Construction Clients
    final List<Map<String, String>> clientsList = [
      {
        'name': 'ABC Construction',
        'initials': 'AC',
        'project': 'Sylhet Sand Supply',
        'due': '৳৪৫,০০০',
        'date': '২০ মে, ২০২৬',
      },
      {
        'name': 'M/S Satata Traders',
        'initials': 'ST',
        'project': 'Stone & Rod',
        'due': '৳১,২০,০০০',
        'date': '১৮ মে, ২০২৬',
      },
      {
        'name': 'Ahsan Enterprise',
        'initials': 'AE',
        'project': 'Mymensingh Balu',
        'due': '৳৮,৫০০',
        'date': '১৫ মে, ২০২৬',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Client Management Hub',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Premium Search Bar
            TextField(
              controller: controller.searchController,
              onChanged: (value) => controller.onSearchChanged(value),
              decoration: InputDecoration(
                hintText: 'Search client name or project...',
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

            // Active Clients List wrapped in Obx for instant real-time sync
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.filteredPeople.length,
                  itemBuilder: (context, index) {
                    final client = controller.filteredPeople[index];

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
                                backgroundColor: UColors.accentBlue.withValues(
                                  alpha: 0.1,
                                ),
                                child: Text(
                                  client['initials']?.toString() ?? 'CL',
                                  style: const TextStyle(
                                    color: UColors.accentBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                client['name']?.toString() ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                // Fixed: Safely mapping to controller's 'sub' and handling missing 'date'
                                '${client['sub'] ?? ''} \nLast Update: ${client['date'] ?? 'Just Now'}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Total Due',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '৳${(client['due']as num).toInt()}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: UColors.lossRed,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 16),
                            // Quick Action Buttons inside the Hub
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      side: const BorderSide(
                                        color: UColors.profitGreen,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () =>
                                        Get.to(() => const CreateInvoiceScreen()),
                                    icon: const Icon(
                                      Iconsax.receipt_add,
                                      size: 16,
                                      color: UColors.profitGreen,
                                    ),
                                    label: const Text(
                                      'New Bill',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: UColors.profitGreen,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: UColors.accentBlue,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      // Future: Record Payment Entry Sheet
                                    },
                                    icon: const Icon(
                                      Iconsax.card_receive,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'Receive Taka',
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
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: UColors.profitGreen,
        onPressed: () => Get.to(() => const AddNewClientScreen()),
        icon: const Icon(Iconsax.user_add, color: Colors.white),
        label: const Text(
          'Add New Client',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}