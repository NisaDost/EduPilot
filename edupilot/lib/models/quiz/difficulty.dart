enum Difficulty {
  easy (
    name: 'Kolay'
  ),
  medium (
    name: 'Orta'
  ),
  hard (
    name: 'Zor'
  );

  const Difficulty ({
    required this.name,
  });

  final String name;
}