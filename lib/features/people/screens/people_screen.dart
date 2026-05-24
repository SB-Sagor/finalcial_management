import 'package:finalcial_management/features/people/controllers/people_controller.dart';
import 'package:finalcial_management/features/people/screens/widgets/search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constraints/u_colors.dart';
import '../controllers/transaction_profile_controller.dart';
import 'transaction_profile_screen.dart';
import 'widgets/people_card.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PeopleController());
    final profileController = Get.put(TransactionProfileController());
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: Text('people_title'.tr),
        centerTitle: false,
        elevation: 0,
      ),

      body: Column(
        children: [
          USearchInputField(
            controller: controller.searchController,
            hintText: 'খুঁজুন (যেমন: ABC, Rahim...)',
            onChanged: (value) => controller.onSearchChanged(value),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isLight ? Colors.grey.shade200 : UColors.surface2Dark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(() => Row(
              children: ['all', 'clients', 'employees'].map((tab) {
                final isSelected = controller.selectedTab.value == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => controller.changeTab(tab),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isLight ? Colors.white : UColors.surface3Dark)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tab == 'all' ? 'tab_all'.tr : (tab == 'clients' ? 'tab_clients'.tr : 'tab_employees'.tr),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected
                              ? (isLight ? Colors.black : UColors.textPrimaryDark)
                              : (isLight ? Colors.grey.shade600 : UColors.textSecondaryDark),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Obx(() => Row(
              children: [
                _buildFilterChip(controller, 'all', 'filter_all'.tr),
                _buildFilterChip(controller, 'due', 'filter_due'.tr),
                _buildFilterChip(controller, 'clear', 'filter_clear'.tr),
                _buildFilterChip(controller, 'new', 'filter_new'.tr),
              ],
            )),
          ),

          const SizedBox(height: 4),

          Expanded(
            child: Obx(() {
              final list = controller.filteredPeople;
              if (list.isEmpty) {
                return Center(child: Text('no_data'.tr, style: const TextStyle(color: UColors.textSecondaryDark)));
              }
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final person = list[index];
                  return UPeopleCard(
                    name: person['name'],
                    subtitle: person['sub'],
                    initials: person['initials'],
                    dueAmount: person['due'],
                    isClient: person['type'] == 'client',
                    onTap: () {
                      profileController.loadProfile(person);
                      Get.to(() => const TransactionProfileScreen());
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(PeopleController controller, String filterKey, String label) {
    final isSelected = controller.selectedFilter.value == filterKey;
    return GestureDetector(
      onTap: () => controller.changeFilter(filterKey),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? UColors.profitGreen.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? UColors.profitGreen : Colors.grey.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? UColors.profitGreen : UColors.textSecondaryDark,
          ),
        ),
      ),
    );
  }
}