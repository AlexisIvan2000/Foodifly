import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'AppState.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .animate(_controller);
    _controller.forward();
  }

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Ajouter ici la logique d'upload si besoin
    }
  }

  void _openEditDialog() {
    final appState = context.read<AppState>();

    final nameController = TextEditingController(text: appState.foodtruckName);
    final descriptionController =
        TextEditingController(text: appState.description);
    final emailController = TextEditingController(text: appState.email);
    final phoneController = TextEditingController(text: appState.telephone);
    final addressController =
        TextEditingController(text: appState.localisation);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Modifier les informations"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildValidatedTextField(nameController, "Nom du food truck"),
                _buildValidatedTextField(descriptionController, "Description"),
                _buildValidatedTextField(emailController, "Email",
                    emailValidation: true),
                _buildValidatedTextField(phoneController, "Téléphone",
                    phoneValidation: true),
                _buildValidatedTextField(addressController, "Adresse"),
                const SizedBox(height: 12),
                _buildTimePickerRow(
                    "Heure d’ouverture", appState.heureOuverture, true),
                _buildTimePickerRow(
                    "Heure de fermeture", appState.heureFermeture, false),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Annuler")),
            ElevatedButton(
              onPressed: () {
                if (!_isValidEmail(emailController.text)) {
                  _showSnackBar("Email invalide");
                  return;
                }
                if (!_isValidPhone(phoneController.text)) {
                  _showSnackBar("Téléphone invalide (format : 204-123-4567)");
                  return;
                }

                appState.updateFoodtruckName(nameController.text);
                appState.updateDescription(descriptionController.text);
                appState.updateFoodtruckEmail(emailController.text);
                appState.updateFoodtruckPhoneNumber(phoneController.text);
                appState.updateFoodtruckAddress(addressController.text);

                Navigator.pop(context);
                _showSnackBar("Modifications enregistrées !");
              },
              child: const Text("Enregistrer"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimePickerRow(String label, String time, bool isOpening) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        TextButton(
          onPressed: () async {
            final selected = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(DateTime.parse("1970-01-01 $time")),
            );
            if (selected != null) {
              final formatted = selected.format(context);
              if (isOpening) {
                context.read<AppState>().updateOpeningHours(formatted);
              } else {
                context.read<AppState>().updateClosingHours(formatted);
              }
            }
          },
          child: Text(time),
        )
      ],
    );
  }

  bool _isValidEmail(String value) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value);
  }

  bool _isValidPhone(String value) {
    return RegExp(r"^\d{3}-\d{3}-\d{4}$").hasMatch(value);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildValidatedTextField(
      TextEditingController controller, String label,
      {bool emailValidation = false, bool phoneValidation = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: emailValidation
            ? TextInputType.emailAddress
            : (phoneValidation ? TextInputType.phone : TextInputType.text),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(label, style: const TextStyle(color: Colors.grey))),
          Expanded(
            flex: 3,
            child: Text(
              value?.isNotEmpty == true ? value! : "Non renseigné",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sécurité & Informations"),
        backgroundColor: const Color.fromARGB(255, 226, 170, 170),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              decoration: _boxDecoration(),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: appState.profileImage != null
                            ? FileImage(File(appState.profileImage!))
                            : (appState.imageUrl.isNotEmpty
                                ? NetworkImage(appState.imageUrl)
                                : null),
                        child: appState.profileImage == null &&
                                appState.imageUrl.isEmpty
                            ? const Icon(Icons.person,
                                size: 45, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildRow("Nom", appState.foodtruckName),
                  _buildRow("Description", appState.description),
                  _buildRow("Email", appState.email),
                  _buildRow("Téléphone", appState.telephone),
                  _buildRow("Adresse", appState.localisation),
                  _buildRow("Horaires",
                      "${appState.heureOuverture} - ${appState.heureFermeture}"),
                  _buildRow(
                      "Créé le",
                      DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(appState.dateCreation))),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _openEditDialog,
                    icon: const Icon(Icons.edit),
                    label: const Text("Modifier"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 204, 155, 184),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
