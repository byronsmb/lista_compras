import 'package:flutter/material.dart';
import 'package:lista_compras/data/datos_ficticios.dart';
import 'package:lista_compras/models/producto.dart';
import 'package:lista_compras/models/screens/agregar_producto.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _eliminarItem(Producto producto) {
    setState(() {
      //_comprasItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AgregarProducto();
                },
              ));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: listaProductos.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(listaProductos[index].id),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Remover Producto"),
                    content: const Text("Esta seguro de eliminar este item?"),
                    actions: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Si")),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("No"),
                      ),
                    ],
                  );
                },
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                // backgroundColor: const Color(0xff764abc),
                child: Text(index.toString()),
              ),
              title: Text(listaProductos[index].nombre),
              subtitle: Text(listaProductos[index].cantidad.toString()),
              trailing: Text(listaProductos[index].categoria.name),
            ),
          );
        },
      ), //Center(child: Text('No hay ningun producto agregado')),
    );
  }
}
