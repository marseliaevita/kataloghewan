import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../widgets/pet_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All";
  String searchQuery = "";

  final List<Pet> pets = [
    Pet(name: "Milo", type: "Cat", description: "Kucing Persia", image: "assets/images/cat1.jpg"),
    Pet(name: "Buddy", type: "Dog", description: "Anjing Golden", image: "assets/images/dog1.jpg"),
    Pet(name: "Snowy", type: "Rabbit", description: "Kelinci Putih", image: "assets/images/rabbit1.jpg"),
    Pet(name: "Coco", type: "Bird", description: "Burung Parkit", image: "assets/images/bird1.jpg"),
    Pet(name: "Nemo", type: "Fish", description: "Ikan Emas", image: "assets/images/fish1.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredPets = pets.where((pet) {
      final matchesCategory = selectedCategory == "All" || pet.type == selectedCategory;
      final matchesSearch = pet.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    Text(
                      "🐾 CritterCare",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Adopt a pet. Love a friend.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Search
              TextField(
                decoration: InputDecoration(
                  hintText: "Search by name...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
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

              // Category
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

              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Available Pets",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${filteredPets.length} found",
                    style: TextStyle(color: Colors.grey.shade600),
                  )
                ],
              ),
              const SizedBox(height: 10),

              // Pet List
              Expanded(
                child: filteredPets.isEmpty
                    ? Center(
                        child: Text(
                          "No pets found",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                        ),
                      )
                    : isDesktop
                        ? GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 3 / 2.5,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: filteredPets.length,
                            itemBuilder: (context, index) {
                              return PetCard(pet: filteredPets[index]);
                            },
                          )
                        : ListView.builder(
                            itemCount: filteredPets.length,
                            itemBuilder: (context, index) {
                              return PetCard(pet: filteredPets[index]);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.shade600 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade800,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}