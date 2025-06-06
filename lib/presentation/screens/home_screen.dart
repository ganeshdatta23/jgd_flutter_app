import 'package:flutter/material.dart';
import 'package:sri_guru_dig_vandanam/presentation/screens/admin/admin_login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: 'Admin Login',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('AR Darshanam will be here.'),
      ),
    );
  }
}
