// lib/widgets/restaurante_card.dart
import 'package:aula1/restaurante.dart';
import 'package:flutter/material.dart';

class RestauranteCard extends StatelessWidget{
  final Restaurante restaurante;
  const RestauranteCard({required this.restaurante});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.restaurant)),
        title: Text(restaurante.nome ?? 'Sem nome'),
        subtitle: Text(restaurante.tipo ?? 'Tipo não informado'),
        trailing: Icon(Icons.chevron_right),
        onTap: (){
          // ação ao abrir restaurante
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Abrir ${restaurante.nome}')));
        },
      ),
    );
  }
}
