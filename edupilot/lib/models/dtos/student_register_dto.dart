class StudentRegisterDTO {
  final String name;
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
    required this.name,
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
        name: json['Name'] as String,
        middleName: json['MiddleName'] as String?,
        lastName: json['LastName'] as String,
        grade: json['Grade'] as int,
        email: json['Email'] as String,
        password: json['Password'] as String,
        phoneNumber: json['PhoneNumber'] as String,
        avatar: json['Avatar'] as String,
        favoriteLessons:
            (json['FavoriteLessons'] as List<dynamic>).map((e) => e as String).toList(),
        supervisorName: json['SupervisorName'] as String?,
        supervisorUniqueCode: json['SupervisorUniqueCode'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'Name': name,
        'MiddleName': middleName,
        'LastName': lastName,
        'Grade': grade,
        'Email': email,
        'Password': password,
        'PhoneNumber': phoneNumber,
        'Avatar': avatar,
        'FavoriteLessons': favoriteLessons,
        'SupervisorName': supervisorName,
        'SupervisorUniqueCode': supervisorUniqueCode,
      };
}