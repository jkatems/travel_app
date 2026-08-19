import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/models/destination.dart';
import 'package:travel_app/widgets/back_to_safe_screen_button.dart';

class BookingFormScreen extends StatefulWidget {
  final Destination? destination;

  const BookingFormScreen({super.key, this.destination});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime? _selectedDate;
  int _travelers = 1;
  String _accommodationType = 'Hotel';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Réservation confirmée'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nom: ${_nameController.text}'),
              Text('Email: ${_emailController.text}'),
              Text('Téléphone: ${_phoneController.text}'),
              if (_selectedDate != null)
                Text('Date: ${_selectedDate!.toLocal()}'.split(' ')[0]),
              Text('Voyageurs: $_travelers'),
              Text('Hébergement: $_accommodationType'),
              if (widget.destination != null)
                Text('Destination: ${widget.destination!.name}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.destination != null
              ? 'Réserver - ${widget.destination!.name}'
              : 'Formulaire de réservation',
        ),
        leading: const BackToSafeScreenButton(
          fallbackRoute: 'home',
          tooltip: "Retour à l'accueil",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;

            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isTablet)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildPersonalInfoSection()),
                        const SizedBox(width: 24),
                        Expanded(child: _buildTripDetailsSection()),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildPersonalInfoSection(),
                        const SizedBox(height: 24),
                        _buildTripDetailsSection(),
                      ],
                    ),

                  const SizedBox(height: 32),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: const Icon(Icons.send),
                      label: const Text('Confirmer la réservation'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations personnelles',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Nom complet',
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre nom';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre email';
            }
            if (!value.contains('@')) {
              return 'Veuillez entrer un email valide';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Téléphone',
            prefixIcon: Icon(Icons.phone),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre numéro';
            }
            if (value.length < 10) {
              return 'Numéro invalide (min 10 chiffres)';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTripDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Détails du voyage',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        // Date Picker
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.calendar_today),
          title: const Text('Date de départ'),
          subtitle: Text(
            _selectedDate != null
                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                : 'Sélectionner une date',
          ),
          onTap: _selectDate,
        ),
        const SizedBox(height: 16),

        // Number of Travelers
        Row(
          children: [
            const Icon(Icons.people),
            const SizedBox(width: 16),
            const Text('Voyageurs: '),
            const Spacer(),
            IconButton(
              onPressed: () {
                if (_travelers > 1) {
                  setState(() {
                    _travelers--;
                  });
                }
              },
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text('$_travelers', style: Theme.of(context).textTheme.titleMedium),
            IconButton(
              onPressed: () {
                setState(() {
                  _travelers++;
                });
              },
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Accommodation Type
        DropdownButtonFormField<String>(
          value: _accommodationType,
          decoration: const InputDecoration(
            labelText: 'Type d\'hébergement',
            prefixIcon: Icon(Icons.hotel),
          ),
          items: ['Hotel', 'Auberge', 'Appartement', 'Villa', 'Camping']
              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
              .toList(),
          onChanged: (value) {
            setState(() {
              _accommodationType = value!;
            });
          },
        ),
        const SizedBox(height: 16),

        if (widget.destination != null)
          Card(
            child: ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue.shade700),
              title: Text(widget.destination!.name),
              subtitle: Text('${widget.destination!.price}\$ par personne'),
              trailing: Text(
                '${widget.destination!.price * _travelers}\$ total',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}
