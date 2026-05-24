import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/u_colors.dart';

class UDashboardModals {
  static void showInstantHub({
    required BuildContext context,
    required String title,
    required String hintText,
    required List<Map<String, String>> shortList,
    required VoidCallback onAddAction,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: const Icon(Iconsax.search_normal, size: 18),
                filled: true,
                fillColor: isLight ? Colors.grey.shade100 : UColors.surfaceDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Recent Entries', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: UColors.textSecondaryDark)),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: shortList.length,
              itemBuilder: (context, index) {
                final item = shortList[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: UColors.profitGreen.withOpacity(0.1),
                    child: Text(item['initials'] ?? '', style: const TextStyle(color: UColors.profitGreen, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  title: Text(item['name'] ?? '', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  subtitle: Text(item['subtitle'] ?? '', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  trailing: Text(item['meta'] ?? '', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: UColors.lossRed)),
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: UColors.profitGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  onAddAction();
                },
                icon: const Icon(Iconsax.add, color: Colors.white, size: 18),
                label: Text('Add New ${title.split(' ').first}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}