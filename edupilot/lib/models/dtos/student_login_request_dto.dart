class StudentLoginRequestDTO {
  final String email;
  final String password;

  const StudentLoginRequestDTO({
    required this.email,
    required this.password,
  });

  factory StudentLoginRequestDTO.fromJson(Map<String, dynamic> json) =>
      StudentLoginRequestDTO(
        email: json['email'] as String,
        password: json['password'] as String,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

}