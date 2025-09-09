import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../pages/detail_page.dart';

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigasi ke halaman detail
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(pet: pet),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(pet.image, width: 60, fit: BoxFit.cover),
          ),
          title: Text(pet.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          subtitle: Text(pet.type, style: const TextStyle(color: Colors.grey)),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
        ),
      ),
    );
  }
}
