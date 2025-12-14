import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_riverpod/providers/auth_provider.dart';
import 'package:project_riverpod/screens/auth/login_screen.dart';
import 'package:project_riverpod/screens/home/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // tambahkan ini
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp())); // ProviderScope di sini
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    return MaterialApp(
      title: 'Project Riverpod',
      debugShowCheckedModeBanner: false,
      home:
          user == null
              ? LoginScreen()
              : user.emailVerified == true
              ? HomeScreen()
              : LoginScreen(),
    );
  }
}
