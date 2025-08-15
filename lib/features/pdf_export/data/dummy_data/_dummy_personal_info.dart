// features/pdf_export/data/dummy_data/_dummy_personal_info.dart
part of 'cv_data_dummy.dart';

PersonalInfo _createDummyPersonalInfo() {
  return PersonalInfo(
    name: 'Salm Mroan',
    jobTitle: 'Graphics Designer & Digital Artist',
    email: 'salm_mroan@gmail.com',
    phone: '+123-456-7890',
    address: '123 Anywhere Street, Any City, ST 12345',
    profileImagePath: 'assets/images/face_AI.webp',
    summary:
        'Highly creative and detail-oriented Senior Graphic Designer with over 8 years of experience in developing engaging and innovative digital and print designs for clients in a broad range of industries. Proficient in Adobe Creative Suite and skilled in visual strategy, layout development, and branding. Seeking to leverage my design expertise to contribute to a dynamic team and create impactful visual solutions.',
    birthDate: DateTime(1992, 8, 24),
    maritalStatus: 'Single',
    militaryServiceStatus: 'Completed',
    // ✅ NEW: Driving license info added as requested.
    hasDriverLicense: true,
    licenseType: LicenseType.both,
  );
}
