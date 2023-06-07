class Place {
  final String name;
  final String imagePath;
  final String ?rating;
  final String desc;

  const Place(
    {required this.name, required this.imagePath, this.rating, required this.desc}
  );
}
