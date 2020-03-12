class PersonModel {
  final String id;
  final String username;

  PersonModel(this.id, this.username);
}

class ContactInfoModel {
  final String address;
  final String email;
  final String name;
  final String phone;

  ContactInfoModel(this.address, this.email, this.name, this.phone);
}

class EducationInfoModel {
  final String primary;
  final String secondary;
  final String university;

  EducationInfoModel(this.primary, this.secondary, this.university);
}
