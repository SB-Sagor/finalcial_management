import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/u_colors.dart';
import '../../../people/controllers/people_controller.dart';

class AddNewClientScreen extends StatefulWidget {
  const AddNewClientScreen({super.key});

  @override
  State<AddNewClientScreen> createState() => _AddNewClientScreenState();
}

class _AddNewClientScreenState extends State<AddNewClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _projectController = TextEditingController();
  final _initialDueController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _projectController.dispose();
    _initialDueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Client', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Client Name Input
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Client or Company Name',
                  prefixIcon: const Icon(Iconsax.user, size: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter client name' : null,
              ),
              const SizedBox(height: 16),

              // Phone Number Input
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Iconsax.call, size: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter phone number' : null,
              ),
              const SizedBox(height: 16),

              // Project / Site Location Input
              TextFormField(
                controller: _projectController,
                decoration: InputDecoration(
                  labelText: 'Project / Site Name (e.g., Mirpur Site)',
                  prefixIcon: const Icon(Iconsax.location, size: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter project name' : null,
              ),
              const SizedBox(height: 16),

              // Initial Due Amount Input (If any previous balance exists)
              TextFormField(
                controller: _initialDueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Previous Due Amount (Optional)',
                  prefixIcon: const Icon(Iconsax.money_3, size: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: '0.00',
                ),
              ),
              const SizedBox(height: 32),

              // Save Client Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UColors.profitGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final double due = double.tryParse(_initialDueController.text.trim()) ?? 0.0;

                      // Safe chaining via localized initialized reference
                      final peopleController = Get.find<PeopleController>();
                      peopleController.addClient(
                        _nameController.text.trim(),
                        _projectController.text.trim(),
                        due,
                      );

                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Iconsax.user_add, color: Colors.white),
                  label: const Text('Save Client Info', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}