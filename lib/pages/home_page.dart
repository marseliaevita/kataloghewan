import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../widgets/pet_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All"; // default All biar semua tampil
  String searchQuery = "";

  //Daftar hewan (dari kode awal)
  final List<Pet> pets = [
    Pet(name: "Milo", type: "Cat", description: "Kucing Persia", image: "assets/images/cat1.jpg"),
    Pet(name: "Buddy", type: "Dog", description: "Anjing Golden", image: "assets/images/dog1.jpg"),
    Pet(name: "Snowy", type: "Rabbit", description: "Kelinci Putih", image: "assets/images/rabbit1.jpg"),
    Pet(name: "Coco", type: "Bird", description: "Burung Parkit", image: "assets/images/bird1.jpg"),
    Pet(name: "Nemo", type: "Fish", description: "Ikan Emas", image: "assets/images/fish1.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    //Filter hewan berdasarkan kategori & search
    final filteredPets = pets.where((pet) {
      final matchesCategory = selectedCategory == "All" || pet.type == selectedCategory;
      final matchesSearch = pet.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search pet...",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              //Category Buttons
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategory("All"),
                    _buildCategory("Cat"),
                    _buildCategory("Dog"),
                    _buildCategory("Rabbit"),
                    _buildCategory("Bird"),
                    _buildCategory("Fish"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //Title
              Text("Newest Pet",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              //Pet List
              Expanded(
                child: filteredPets.isEmpty
                    ? Center(child: Text("No pets found"))
                    : ListView.builder(
                        itemCount: filteredPets.length,
                        itemBuilder: (context, index) {
                          final pet = filteredPets[index];
                          return PetCard(pet: pet);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Category Button
  Widget _buildCategory(String category) {
    final isSelected = category == selectedCategory;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
