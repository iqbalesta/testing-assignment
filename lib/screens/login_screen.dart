import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.authState == AuthState.loggedIn) {
        Navigator.of(context).pushReplacementNamed('/tasks');
      }
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                onChanged: (v) => _username = v,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (v) => _password = v,
                validator: (v) => v != null && v.length < 4 ? 'Min 4 chars' : null,
              ),
              const SizedBox(height: 16),
              if (provider.authState == AuthState.loading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      provider.login(_username, _password);
                    }
                  },
                  child: const Text('Login'),
                ),
              if (provider.authState == AuthState.error)
                Text(provider.errorMessage ?? 'Login error', style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
