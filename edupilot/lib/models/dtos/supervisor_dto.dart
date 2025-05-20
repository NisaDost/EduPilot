class SupervisorDTO {
  final String id;
  final String? institutionId;
  final List<String>? studentIds;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final int uniqueCode;

  const SupervisorDTO({
    required this.id,
    this.institutionId,
    this.studentIds,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.uniqueCode,
  });

  factory SupervisorDTO.fromJson(Map<String, dynamic> json) => SupervisorDTO(
        id: json['id'] as String,
        institutionId: json['institutionId'] as String?,
        studentIds: (json['studentIds'] as List<dynamic>).map((e) => e as String).toList(),
        firstName: json['firstName'] as String,
        middleName: json['middleName'] as String?,
        lastName: json['lastName'] as String,
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
        uniqueCode: json['uniqueCode'] as int,
      );
      
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'uniqueCode': uniqueCode,
      };
}
