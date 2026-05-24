import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeopleController extends GetxController {
  static PeopleController get instance => Get.find();

  final searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  RxString selectedTab = 'all'.obs;
  RxString selectedFilter = 'all'.obs;

  final RxList<Map<String, dynamic>> rawPeopleList = <Map<String, dynamic>>[
    {
      'id': '1',
      'name': 'ABC Construction',
      'sub': 'সিলেট ভিটি বালু সরবরাহ',
      'initials': 'AC',
      'due': 45000,
      'type': 'client',
      'isNew': false,
    },
    {
      'id': '2',
      'name': 'Rahim Mia',
      'sub': 'ঢাকা-চট্টগ্রাম ট্রিপ (ট্রাক #০৩)',
      'initials': 'RM',
      'due': 0,
      'type': 'employee',
      'isNew': false,
    },
    {
      'id': '3',
      'name': 'M/S Satata Traders',
      'sub': 'পাথর ও রড সাপ্লাই',
      'initials': 'ST',
      'due': 120000,
      'type': 'client',
      'isNew': true,
    },
    {
      'id': '4',
      'name': 'Karim Uddin',
      'sub': 'হেলপার (ঢাকা মেট্রো-ট)',
      'initials': 'KU',
      'due': 3500,
      'type': 'employee',
      'isNew': true,
    },
  ].obs;

  void addClient(String name, String project, double dueAmount) {
    final String initials = name.length >= 2
        ? name.substring(0, 2).toUpperCase()
        : 'CL';
    rawPeopleList.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': name,
      'sub': project,
      'initials': initials,
      'due': dueAmount,
      'type': 'client',
      'isNew': true,
    });
  }

  void addEmployee(String name, String role, String truckNumber, String phone, int advanceAmount) {
    final String initials = name.length >= 2
        ? name.substring(0, 2).toUpperCase()
        : 'EM';

    final String subText = truckNumber.isNotEmpty
        ? '$role (Truck #$truckNumber)'
        : role;

    rawPeopleList.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': name,
      'sub': subText,
      'initials': initials,
      'due': advanceAmount,
      'phone': phone,
      'type': 'employee',
      'isNew': true,
    });
  }

  List<Map<String, dynamic>> get filteredPeople {
    return rawPeopleList.where((person) {
      final matchesSearch =
          person['name'].toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
              person['sub'].toLowerCase().contains(searchQuery.value.toLowerCase());

      bool matchesTab = true;
      if (selectedTab.value == 'clients')
        matchesTab = person['type'] == 'client';
      if (selectedTab.value == 'employees')
        matchesTab = person['type'] == 'employee';

      bool matchesChip = true;
      if (selectedFilter.value == 'due') matchesChip = person['due'] > 0;
      if (selectedFilter.value == 'clear') matchesChip = person['due'] == 0;
      if (selectedFilter.value == 'new') matchesChip = person['isNew'] == true;

      return matchesSearch && matchesTab && matchesChip;
    }).toList();
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}