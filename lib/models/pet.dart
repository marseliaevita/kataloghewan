class Pet {
  final String name;           // Nama hewan
  final String type;           // Jenis hewan (kucing, anjing, dll)
  final String image;          // Path gambar
  final String characteristics; // Karakteristik hewan
  final String careTips;        // Tips perawatan

  Pet({
    required this.name,
    required this.type,
    required this.image,
    required this.characteristics,
    required this.careTips,
  });
}
