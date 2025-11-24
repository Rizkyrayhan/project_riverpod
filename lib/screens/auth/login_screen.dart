import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_riverpod/providers/auth_provider.dart';
import 'package:project_riverpod/screens/home/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final cEmail = TextEditingController();
  final cPass = TextEditingController();

  bool isLoading = false;

  void doLogin() async {
    final result = await ref
        .read(authProvider.notifier)
        .login(cEmail.text, cPass.text);

    if (result == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardAdmin()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Firebase"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
              controller: cEmail,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: cPass,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: doLogin, child: Text("Login")),
            SizedBox(height: 10),
            TextButton(onPressed: () {}, child: Text("Reset Password")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun?"),
                TextButton(onPressed: () {}, child: Text("Daftar disini!")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
