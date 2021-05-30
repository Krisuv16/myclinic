class PatProfile {
  int phone_number;
  String email;
  String firstName;
  String lastName;
  String dob;
  String gender_type;
  String address;
  String blood_type;
  String profile_pic;
  PatProfile(
      {this.phone_number,
      this.email,
      this.firstName,
      this.lastName,
      this.dob,
      this.gender_type,
      this.address,
      this.blood_type,
      this.profile_pic});

  factory PatProfile.fromJson(Map<String, dynamic> json) {
    return PatProfile(
        phone_number: json['phone_number'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        dob: json['dob'],
        gender_type: json['gender_type'],
        address: json['address'],
        blood_type: json['blood_type'],
        profile_pic: json['profile_pic']);
  }
}
