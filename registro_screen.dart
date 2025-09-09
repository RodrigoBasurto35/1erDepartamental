import 'package:flutter/material.dart';
import 'main.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmarPasswordController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmarPasswordFocus = FocusNode();

  bool _mostrarPassword = false;
  bool _mostrarConfirmarPassword = false;
  bool _aceptaTerminos = false;
  bool _intentoEnvio = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmarPasswordController.dispose();

    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmarPasswordFocus.dispose();

    super.dispose();
  }

  void _enviarFormulario() {
    setState(() {
      _intentoEnvio = true;
    });

    final form = _formKey.currentState!;
    if (!form.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor corrige los errores del formulario.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (!_aceptaTerminos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes aceptar los términos y condiciones.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final nombre = _nombreController.text;
    final email = _emailController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡Registro exitoso! Bienvenido $nombre ($email)'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _limpiarFormulario() {
    _formKey.currentState?.reset();
    _nombreController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmarPasswordController.clear();

    setState(() {
      _intentoEnvio = false;
      _mostrarPassword = false;
      _mostrarConfirmarPassword = false;
      _aceptaTerminos = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Práctica 3: Registro',
      currentPage: 'Registro',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: _intentoEnvio
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_emailFocus),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El nombre es obligatorio';
                  } else if (value.trim().length < 3) {
                    return 'Debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_passwordFocus),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El email es obligatorio';
                  }
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Correo electrónico no válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                obscureText: !_mostrarPassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_mostrarPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _mostrarPassword = !_mostrarPassword;
                      });
                    },
                  ),
                ),
                onFieldSubmitted: (_) => FocusScope.of(context)
                    .requestFocus(_confirmarPasswordFocus),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La contraseña es obligatoria';
                  } else if (value.length < 6) {
                    return 'Debe tener al menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmarPasswordController,
                focusNode: _confirmarPasswordFocus,
                obscureText: !_mostrarConfirmarPassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_mostrarConfirmarPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _mostrarConfirmarPassword = !_mostrarConfirmarPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirma tu contraseña';
                  } else if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                title: const Text('Acepto los términos y condiciones'),
                value: _aceptaTerminos,
                onChanged: (value) {
                  setState(() => _aceptaTerminos = value ?? false);
                },
                controlAffinity: ListTileControlAffinity.leading,
                subtitle: _intentoEnvio && !_aceptaTerminos
                    ? const Text(
                        'Debes aceptar los términos y condiciones',
                        style: TextStyle(color: Colors.red),
                      )
                    : null,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _enviarFormulario,
                    child: const Text('Enviar'),
                  ),
                  OutlinedButton(
                    onPressed: _limpiarFormulario,
                    child: const Text('Limpiar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
