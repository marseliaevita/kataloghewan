import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../widgets/pet_card.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Pet> pets = [
    Pet(
      name: "Milo",
      type: "Kucing",
      image: "assets/images/cat1.jpg",
      characteristics: "Jinak, suka bermain, manja.",
      careTips: "Beri makan 2x sehari, sediakan pasir untuk litter box.",
    ),
    Pet(
      name: "Buddy",
      type: "Anjing",
      image: "assets/images/dog1.jpg",
      characteristics: "Setia, aktif, ramah.",
      careTips: "Ajak jalan tiap pagi, beri mainan untuk digigit.",
    ),
    Pet(
      name: "Snowy",
      type: "Kelinci",
      image: "assets/images/rabbit1.jpg",
      characteristics: "Tenang, pemalu, suka mengunyah.",
      careTips: "Berikan sayuran segar, sediakan kandang luas.",
    ),
    Pet(
      name: "Coco",
      type: "Burung",
      image: "assets/images/bird1.jpg",
      characteristics: "Ceria, suka berkicau, mudah jinak.",
      careTips: "Beri biji-bijian, bersihkan sangkar tiap hari.",
    ),
    Pet(
      name: "Nemo",
      type: "Ikan",
      image: "assets/images/fish1.jpg",
      characteristics: "Indah, tenang, mudah dirawat.",
      careTips: "Ganti air akuarium seminggu sekali.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Katalog Hewan Peliharaan")),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return PetCard(
            pet: pets[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(pet: pets[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
