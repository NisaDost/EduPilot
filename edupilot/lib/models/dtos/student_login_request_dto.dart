class StudentLoginRequestDTO {
  final String email;
  final String password;

  const StudentLoginRequestDTO({
    required this.email,
    required this.password,
  });

  factory StudentLoginRequestDTO.fromJson(Map<String, dynamic> json) =>
      StudentLoginRequestDTO(
        email: json['Email'] as String,
        password: json['Password'] as String,
      );

  Map<String, dynamic> toJson() => {
        'Email': email,
        'Password': password,
      };

}