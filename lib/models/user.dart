class User {
  final String name;
  final String imageProfile;
  final String ?rating;
  final String desc;

  const User(
    {required this.name, required this.imageProfile, this.rating, required this.desc}
  );
}
