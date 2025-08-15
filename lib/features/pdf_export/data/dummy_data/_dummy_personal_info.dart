// features/pdf_export/data/dummy_data/_dummy_personal_info.dart
part of 'cv_data_dummy.dart';

PersonalInfo _createDummyPersonalInfo() {
  return PersonalInfo(
    name: 'Salm Mroan',
    jobTitle: 'Graphics Designer',
    email: 'salm_mroan@gmail.com',
    phone: '+123-456-7890',
    address: '123 Anywhere Street, Any City',
    profileImagePath: 'assets/images/face_AI.webp',
    summary:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pharetra in lorem at laoreet. Donec hendrerit libero eget tempor, quis tempus arcu elementum.',
    birthDate: DateTime(1992, 8, 24),
    maritalStatus: 'Single',
    militaryServiceStatus: 'Completed',
    // ✅ NEW: Driving license info added as requested.
    hasDriverLicense: true,
    licenseType: LicenseType.both,
  );
}
