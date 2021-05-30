class Tryyy {
  Owner owner;
  String roomId;
  String startTime;
  Patient patient;

  Tryyy({this.owner, this.roomId, this.startTime, this.patient});

  Tryyy.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    roomId = json['room_id'];
    startTime = json['start_time'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['room_id'] = this.roomId;
    data['start_time'] = this.startTime;
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    return data;
  }
}

class Owner {
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

  Owner(
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

  Owner.fromJson(Map<String, dynamic> json) {
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

class Patient {
  int user;
  String firstName;
  String lastName;
  String email;
  int phoneNumber;
  String dob;
  String address;
  String genderType;
  String bloodType;
  String profilePic;

  Patient(
      {this.user,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.dob,
      this.address,
      this.genderType,
      this.bloodType,
      this.profilePic});

  Patient.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    dob = json['dob'];
    address = json['address'];
    genderType = json['gender_type'];
    bloodType = json['blood_type'];
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
    data['blood_type'] = this.bloodType;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}