class StudentRegisterDTO {
  final String firstName;
  final String? middleName;
  final String lastName;
  final int grade;
  final String email;
  final String password;
  final String phoneNumber;
  final String avatar;
  final List<String> favoriteLessons;
  final String? supervisorName;
  final int? supervisorUniqueCode;

  const StudentRegisterDTO({
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.grade,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.avatar,
    required this.favoriteLessons,
    this.supervisorName,
    this.supervisorUniqueCode,
  });

  factory StudentRegisterDTO.fromJson(Map<String, dynamic> json) =>
      StudentRegisterDTO(
        firstName: json['firstName'] as String,
        middleName: json['middleName'] as String?,
        lastName: json['lastName'] as String,
        grade: json['grade'] as int,
        email: json['email'] as String,
        password: json['password'] as String,
        phoneNumber: json['phoneNumber'] as String,
        avatar: json['avatar'] as String,
        favoriteLessons:
            (json['favoriteLessons'] as List<dynamic>).map((e) => e as String).toList(),
        supervisorName: json['supervisorName'] as String?,
        supervisorUniqueCode: json['supervisorUniqueCode'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'grade': grade,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'avatar': avatar,
        'favoriteLessons': favoriteLessons,
        'supervisorName': supervisorName,
        'supervisorUniqueCode': supervisorUniqueCode,
      };
}