import 'package:car_rent/view/widget/common/title_section.dart';
import 'package:car_rent/view/widget/personalDetaile/contact_info_section.dart';
import 'package:car_rent/view/widget/personalDetaile/driver_license_section.dart';
import 'package:flutter/material.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final _firstNameController = TextEditingController(text: "Jane");
  final _lastNameController = TextEditingController(text: "Doe");
  final _emailController = TextEditingController(text: "jane.doe@example.com");
  final _phoneController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  String _selectedCountry = "California, USA";
  DateTime? _expiryDate;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _licenseNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Personal Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Contact Information Section
          const SectionTitle(title: "Contact Information"),
          const SizedBox(height: 12),
          ContactInfoSection(
            firstNameController: _firstNameController,
            lastNameController: _lastNameController,
            emailController: _emailController,
            phoneController: _phoneController,
          ),
          const SizedBox(height: 24),

          // Driver’s License Section
          const SectionTitle(title: "Driver's License"),
          const SizedBox(height: 12),
          DriverLicenseSection(
            licenseNumberController: _licenseNumberController,
            selectedCountry: _selectedCountry,
            expiryDate: _expiryDate,
            onCountryChanged: (value) {
              setState(() => _selectedCountry = value);
            },
            onDatePicked: (date) {
              setState(() => _expiryDate = date);
            },
          ),
        ],
      ),

      // Bottom Save Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Changes Saved Successfully')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF005A9C),
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Save Changes",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
