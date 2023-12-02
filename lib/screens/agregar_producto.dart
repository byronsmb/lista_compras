import 'package:flutter/material.dart';
import 'package:lista_compras/models/producto.dart';

class AgregarProducto extends StatefulWidget {
  const AgregarProducto({super.key});

  @override
  State<AgregarProducto> createState() => _AgregarProductoState();
}

class _AgregarProductoState extends State<AgregarProducto> {
  Categoria _selectedCategoria = Categoria.fruta;
  final _formKey = GlobalKey<FormState>();
  var _nombre = '';
  var _cantidad = 1;

  void _guardarProducto() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        Producto(
            nombre: _nombre,
            cantidad: _cantidad,
            categoria: _selectedCategoria),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar producto')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Nombre'),
                ),
                validator: (value) {
                  //cuando validar este formulario
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Debe ser entre 1 y 50 caracteres';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _nombre = newValue!;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Cantidad'),
                      ),
                      initialValue: _cantidad.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value)! <= 0 ||
                            int.tryParse(value) == null) {
                          return 'Debe ser entre 1 y 50 caracteres';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        _cantidad = int.parse(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategoria,
                      items: [
                        for (final categoria in Categoria
                            .values) //entries para obtener los pares clave-valor del map
                          DropdownMenuItem(
                            value: categoria,
                            child: Text(categoria.name),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoria = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text(''),
                  ),
                  ElevatedButton(
                    onPressed: _guardarProducto,
                    child: const Text('Guardar'),
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
