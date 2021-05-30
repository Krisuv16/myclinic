class Appointment {
  String first_name;
  String last_name;
  String email;
  String phone_number;
  String dob;
  String address;
  String gender_type;
  String specialization;
  String about;
  String profile_pic;
  String appointment_date;
  String appointment_time;
  String appointment_details;
  int price;
  Appointment({
    this.first_name,
    this.last_name,
    this.email,
    this.phone_number,
    this.dob,
    this.address,
    this.gender_type,
    this.specialization,
    this.about,
    this.profile_pic,
    this.appointment_date,
    this.appointment_time,
    this.appointment_details,
    this.price,
  });
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      phone_number: json['phone_number'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      dob: json['dob'],
      gender_type: json['gender_type'],
      price: json['price'],
      appointment_details: json['appointment_details'],
      appointment_time: json['appointment_time'],
      appointment_date: json['appointment_date'],
      profile_pic: json['profile_pic'],
      address: json['address'],
      about: json['about'],
      specialization: json['specialization'],
    );
  }
}
