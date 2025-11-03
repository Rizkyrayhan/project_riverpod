import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_riverpod/screens/dashboard_screen.dart';
import 'package:project_riverpod/screens/home/home_provider.dart';
import 'package:project_riverpod/screens/mahasiswa/mahasiswa_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeController = ref.watch(homeProvider); // huruf kecil di awal
    return DashboardAdmin();
  }
}

final indexProvider = StateProvider<int>((ref) => 0);

class DashboardAdmin extends ConsumerWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _index = ref.watch(indexProvider);

    List<Map> _fragment = [
      {'title': 'halaman utama', 'body': DashboardScreen()},
      {'title': 'mahasiswa', 'body': MahasiswaScreen()},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(_fragment[_index]['title']),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add_circle_outline)),
        ],
        backgroundColor: Colors.teal,
      ),
      drawer: drawer(ref, context),
      body: _fragment[_index]['body'],
    );
  }

  Widget drawer(WidgetRef ref, BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.teal),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.account_circle, size: 80, color: Colors.white),
                Text(
                  "Rizky Dwi Rayhan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Manager',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              ref.read(indexProvider.notifier).state = 0;
              Navigator.pop(context);
            },
            leading: const Icon(Icons.home),
            title: const Text("Halaman Utama"),
            trailing: const Icon(Icons.navigate_next),
            iconColor: Colors.teal,
            textColor: Colors.teal,
          ),
          ListTile(
            onTap: () {
              ref.read(indexProvider.notifier).state = 1;
              Navigator.pop(context);
            },
            leading: const Icon(Icons.people),
            title: const Text("Mahasiswa"),
            trailing: const Icon(Icons.navigate_next),
            iconColor: Colors.teal,
            textColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
