// features/cv_form/data/models/reference.dart

part of 'cv_data.dart';

@embedded
class Reference {
  late String name;
  late String company;
  late String position;
  late String email;
  String? phone;

  Reference() {
    name = '';
    company = '';
    position = '';
    email = '';
    phone = '';
  }

  Reference.create({
    required this.name,
    required this.company,
    required this.position,
    required this.email,
    this.phone,
  });
}
