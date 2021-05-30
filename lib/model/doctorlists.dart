class Dlist {
  Doctor doctor;
  String appointmentDate;
  String appointmentTime;
  String appointmentDetails;
  int price;

  Dlist(
      {this.doctor,
      this.appointmentDate,
      this.appointmentTime,
      this.appointmentDetails,
      this.price});

  Dlist.fromJson(Map<String, dynamic> json) {
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    appointmentDetails = json['appointment_details'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    data['appointment_date'] = this.appointmentDate;
    data['appointment_time'] = this.appointmentTime;
    data['appointment_details'] = this.appointmentDetails;
    data['price'] = this.price;
    return data;
  }
}

class Doctor {
  int user;
  String firstName;
  String lastName;
  String email;
  int phoneNumber;
  String dob;
  String address;
  String genderType;
  String specialization;
  String about;
  String profilePic;

  Doctor(
      {this.user,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.dob,
      this.address,
      this.genderType,
      this.specialization,
      this.about,
      this.profilePic});

  Doctor.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    dob = json['dob'];
    address = json['address'];
    genderType = json['gender_type'];
    specialization = json['specialization'];
    about = json['about'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['gender_type'] = this.genderType;
    data['specialization'] = this.specialization;
    data['about'] = this.about;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}
