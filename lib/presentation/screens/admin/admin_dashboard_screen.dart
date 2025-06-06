import 'package:flutter/material.dart';
import 'package:sri_guru_dig_vandanam/models/location_model.dart';
import 'package:sri_guru_dig_vandanam/services/supabase_service.dart';
import 'package:sri_guru_dig_vandanam/utils/constants.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _addressController = TextEditingController();
  final SupabaseService _supabaseService = SupabaseService();
  bool _isLoading = false;

  void _updateLocation() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final url = _urlController.text;
      final address = _addressController.text;

      // Regex to extract coordinates from Google Maps URL
      final regex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
      final match = regex.firstMatch(url);

      if (match != null && match.groupCount >= 2) {
        final lat = double.parse(match.group(1)!);
        final lon = double.parse(match.group(2)!);

        final newLocation = LocationModel(
          id: appajiLocationId,
          latitude: lat,
          longitude: lon,
          googleMapsUrl: url,
          address: address,
          updatedAt: DateTime.now(),
        );

        try {
          await _supabaseService.updateAppajiLocation(newLocation);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location updated successfully!')),
          );
          _urlController.clear();
          _addressController.clear();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating location: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Google Maps URL. Could not find coordinates.')),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address Name (e.g., SGS Ashrama, Mysuru)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Google Maps URL',
                  hintText: 'e.g., https://www.google.com/maps/@12.3,76.6,15z',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL';
                  }
                  if (!value.startsWith('https://www.google.com/maps')) {
                    return 'Please enter a valid Google Maps URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _updateLocation,
                      child: const Text('Update Location'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
} 