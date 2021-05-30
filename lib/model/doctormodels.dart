class DocProfile {
  int phone_number;
  String email;
  String firstName;
  String lastName;
  String dob;
  String gender_type;
  String address;
  String profile_pic;
  String specialization;
  String about;
  DocProfile(
      {this.phone_number,
      this.email,
      this.firstName,
      this.lastName,
      this.dob,
      this.gender_type,
      this.address,
      this.profile_pic,
      this.specialization,
      this.about});

  factory DocProfile.fromJson(Map<String, dynamic> json) {
    return DocProfile(
        phone_number: json['phone_number'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        dob: json['dob'],
        gender_type: json['gender_type'],
        address: json['address'],
        profile_pic: json['profile_pic'],
        specialization: json['specialization'],
        about: json['about']);
  }
}
