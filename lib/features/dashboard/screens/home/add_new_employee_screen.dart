import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/u_colors.dart';
import '../../../people/controllers/people_controller.dart';

class AddNewEmployeeScreen extends StatefulWidget {
  const AddNewEmployeeScreen({super.key});

  @override
  State<AddNewEmployeeScreen> createState() => _AddNewEmployeeScreenState();
}

class _AddNewEmployeeScreenState extends State<AddNewEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _roleController = TextEditingController();
  final _truckNumberController = TextEditingController();
  final _advanceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _roleController.dispose();
    _truckNumberController.dispose();
    _advanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Staff / Driver',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Staff Name',
                  prefixIcon: const Icon(Iconsax.user, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter staff name' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Iconsax.call, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter phone number' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _roleController,
                decoration: InputDecoration(
                  labelText: 'Role (e.g., Driver, Site Manager, Helper)',
                  prefixIcon: const Icon(Iconsax.briefcase, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter job role' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _truckNumberController,
                decoration: InputDecoration(
                  labelText: 'Assigned Truck Number (Optional)',
                  prefixIcon: const Icon(Iconsax.truck_fast, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'e.g., DHAKA-METRO-T-1234',
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _advanceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Initial Advance Given (Optional)',
                  prefixIcon: const Icon(Iconsax.money_3, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: '0',
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UColors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final peopleController = Get.find<PeopleController>();

                      final int advance =
                          int.tryParse(_advanceController.text.trim()) ?? 0;

                      peopleController.addEmployee(
                        _nameController.text.trim(),
                        _roleController.text.trim(),
                        _truckNumberController.text.trim(),
                        _phoneController.text.trim(),
                        advance,
                      );

                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Iconsax.user_add, color: Colors.white),
                  label: const Text(
                    'Save Staff Info',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
