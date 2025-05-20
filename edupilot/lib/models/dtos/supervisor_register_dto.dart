class SupervisorRegisterDTO {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;

  const SupervisorRegisterDTO({
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  factory SupervisorRegisterDTO.fromJson(Map<String, dynamic> json) => SupervisorRegisterDTO(
        firstName: json['firstName'] as String,
        middleName: json['middleName'] as String?,
        lastName: json['lastName'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        phoneNumber: json['phoneNumber'] as String,
      );
      
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
      };
}
