import 'package:flutter/material.dart';
import '../models/pet.dart';

class DetailPage extends StatelessWidget {
  final Pet pet;

  const DetailPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final tips = _getCareTips(pet.type);

    return Scaffold(
      backgroundColor: Colors.orange.shade50, // senada HomePage
      appBar: AppBar(
        title: Text(
          pet.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade800, // senada Home header
        elevation: 2,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 100 : 16,
                vertical: 20,
              ),
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Foto di sebelah kiri
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              pet.image,
                              height: 400,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),

                        // Detail di kanan
                        Expanded(
                          flex: 1,
                          child: _buildDetailSection(pet, tips),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Foto atas
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            pet.image,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Detail bawah
                        _buildDetailSection(pet, tips),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailSection(Pet pet, List<String> tips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nama + Jenis
        Text(
          pet.name,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade800,
          ),
        ),
        Text(
          pet.type,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 20),

        // Karakteristik
        Card(
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.orange.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Karakteristik",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  pet.description,
                  style: const TextStyle(fontSize: 16, height: 1.6),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Tips Perawatan
        Card(
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.orange.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tips Perawatan",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade800,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: tips
                      .map(
                        (tip) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check_circle, color: Colors.orange.shade600, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  tip,
                                  style: const TextStyle(fontSize: 16, height: 1.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static List<String> _getCareTips(String type) {
    switch (type) {
      case "Cat":
        return [
          "Beri makan rutin dengan pakan khusus kucing (dry food / wet food).",
          "Sediakan tempat pasir (litter box) yang selalu bersih.",
          "Ajak bermain setiap hari biar aktif dan sehat.",
          "Vaksin rutin untuk mencegah penyakit.",
          "Sisir bulu secara teratur (terutama kucing berbulu panjang).",
        ];
      case "Dog":
        return [
          "Ajak jalan setiap hari.",
          "Berikan vaksin rutin.",
          "Sediakan mainan agar tidak stres.",
        ];
      case "Rabbit":
        return [
          "Sediakan sayuran segar sebagai makanan tambahan.",
          "Gunakan kandang luas dengan ventilasi baik.",
          "Ajak berinteraksi agar jinak.",
        ];
      case "Bird":
        return [
          "Jaga kebersihan sangkar setiap hari.",
          "Berikan pakan biji-bijian & buah segar.",
          "Biarkan berjemur di sinar matahari pagi.",
        ];
      case "Fish":
        return [
          "Ganti air akuarium secara rutin.",
          "Berikan pakan secukupnya (hindari overfeeding).",
          "Gunakan filter agar air tetap bersih.",
        ];
      default:
        return ["Rawat dengan penuh kasih sayang 💕."];
    }
  }
}
