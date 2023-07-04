class Contact {
  final String id;
  final String username;
  final String description;

  Contact({
    required this.id,
    required this.username,
    this.description = '',
  });
}