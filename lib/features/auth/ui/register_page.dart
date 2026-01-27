import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final bikeModelCtrl = TextEditingController();
  final bikeRegCtrl = TextEditingController();

  Map<String, PlatformFile> pickedFiles = {};

  Future<void> pickFile(String key) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
    );


    if (result != null) {
      setState(() {
        pickedFiles[key] = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rider Registration')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration submitted')),
            );
            Navigator.pop(context);
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _title('Personal Info'),
                _input(nameCtrl, 'Full Name'),
                _input(emailCtrl, 'Email'),
                _input(phoneCtrl, 'Phone'),
                _input(passwordCtrl, 'Password', obscure: true),

                const SizedBox(height: 20),
                _title('Bike Info'),
                _input(bikeModelCtrl, 'Bike Model'),
                _input(bikeRegCtrl, 'Registration Number'),

                const SizedBox(height: 20),
                _title('Documents'),
                _fileTile('photo', 'Passport Photo'),
                _fileTile('citizenshipProof', 'Citizenship'),
                _fileTile('panCard', 'PAN Card'),
                _fileTile('policeRecord', 'Police Record'),
                _fileTile('rcDocument', 'RC Book'),
                _fileTile('insurance', 'Insurance'),

                const SizedBox(height: 30),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final data = {
                            'name': nameCtrl.text,
                            'email': emailCtrl.text,
                            'phone': phoneCtrl.text,
                            'password': passwordCtrl.text,
                            'bikeModel': bikeModelCtrl.text,
                            'bikeRegistrationNumber': bikeRegCtrl.text,
                          };

                          final files = {
                            for (var e in pickedFiles.entries)
                              e.key: e.value.path
                          };

                          context.read<AuthBloc>().add(
                                RegisterRequested(data, files),
                              );
                        }
                      },
                      child: const Text('Submit Registration'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String label,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        obscureText: obscure,
        decoration: InputDecoration(labelText: label),
        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _fileTile(String key, String title) {
    return ListTile(
      title: Text(title),
      subtitle:
          Text(pickedFiles[key]?.name ?? 'Tap to select file'),
      trailing: const Icon(Icons.upload_file),
      onTap: () => pickFile(key),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(text,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
