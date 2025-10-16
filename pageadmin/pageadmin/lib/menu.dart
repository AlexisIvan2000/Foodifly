import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GestionMenuPage extends StatefulWidget {
  final String
      foodTruckId; // ID du food truck pour lequel on gère les menus et items

  const GestionMenuPage({Key? key, required this.foodTruckId})
      : super(key: key);

  @override
  _GestionMenuPageState createState() => _GestionMenuPageState();
}

class _GestionMenuPageState extends State<GestionMenuPage> {
  List<Map<String, dynamic>> menuItems = [];
  bool isLoading =
      true; // Pour afficher un loader pendant le chargement des données

  @override
  void initState() {
    super.initState();
    fetchItemsAndMenus();
  }

  Future<void> fetchItemsAndMenus() async {
    try {
      final truckRef = FirebaseFirestore.instance
          .collection('foodTrucks')
          .doc(widget.foodTruckId);

      final itemsSnapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('foodTruck', isEqualTo: truckRef)
          .get();

      final menusSnapshot = await FirebaseFirestore.instance
          .collection('menus')
          .where('foodTruck', isEqualTo: truckRef)
          .get();

      List<Map<String, dynamic>> allEntries = [];

      // Ajouter les items
      for (var doc in itemsSnapshot.docs) {
        final data = doc.data();
        allEntries.add({
          'image': data['imageUrl'] ?? '',
          'name': data['nom'] ?? '',
          'price': '${(data['prix'] ?? 0).toStringAsFixed(2)} \$',
          'category': 'Item',
          'action': 'Modifier',
        });
      }

      // Ajouter les menus
      for (var doc in menusSnapshot.docs) {
        final data = doc.data();
        allEntries.add({
          'image': data['imageUrl'] ?? '',
          'name': data['nom'] ?? '',
          'price': '${(data['prix'] ?? 0).toStringAsFixed(2)} \$',
          'category': 'Menu',
          'action': 'Modifier',
        });
      }

      setState(() {
        menuItems = allEntries;
        isLoading = false;
      });
    } catch (e) {
      print('Erreur lors du chargement des menus/items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECD8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Gestion des Menu',
            style: TextStyle(color: Colors.grey)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF7F4E8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Gestion du Menu',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          AddMenuItemDialog(foodTruckId: widget.foodTruckId),
                    );
                  },
                  child: const Text('Ajouter un Plat'),
                ),
              ),
              const Divider(height: 1),
              _buildHeaderRow(),
              const Divider(height: 1),
              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemCount: menuItems.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          return _buildDataRow(item);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        children: const [
          Expanded(flex: 2, child: Text('Image')),
          Expanded(flex: 3, child: Text('Nom')),
          Expanded(flex: 2, child: Text('Prix')),
          Expanded(flex: 3, child: Text('Catégorie')),
          Expanded(flex: 2, child: Text('Statut')),
        ],
      ),
    );
  }

  Widget _buildDataRow(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item['image'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(flex: 3, child: Text(item['name'])),
          Expanded(flex: 2, child: Text(item['price'])),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(item['category'],
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black,
              ),
              child: Text(item['action']),
            ),
          ),
        ],
      ),
    );
  }
}
class AddMenuItemDialog extends StatefulWidget {
  final String foodTruckId;

  const AddMenuItemDialog({Key? key, required this.foodTruckId}) : super(key: key);

  @override
  _AddMenuItemDialogState createState() => _AddMenuItemDialogState();
}

class _AddMenuItemDialogState extends State<AddMenuItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  bool _disponible = true;

  Future<void> _addItem() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('items').add({
        'nom': _nomController.text.trim(),
        'prix': double.tryParse(_prixController.text.trim()) ?? 0.0,
        'imageUrl': _imageUrlController.text.trim(),
        'disponible': _disponible,
        'foodTruck': FirebaseFirestore.instance.doc('foodTrucks/${widget.foodTruckId}'),
        'createdAt': FieldValue.serverTimestamp(),
      });

      Navigator.of(context).pop(); // Ferme le dialogue
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter un plat'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom du plat'),
                validator: (value) => value == null || value.isEmpty ? 'Nom requis' : null,
              ),
              TextFormField(
                controller: _prixController,
                decoration: const InputDecoration(labelText: 'Prix'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || double.tryParse(value) == null ? 'Prix invalide' : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              SwitchListTile(
                value: _disponible,
                onChanged: (val) => setState(() => _disponible = val),
                title: const Text("Disponible"),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _addItem,
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}

