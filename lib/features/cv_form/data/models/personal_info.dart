// features/cv_form/data/models/personal_info.dart

part of 'cv_data.dart';

/// ✅ NEW: Enum to define the types of driving licenses.
/// Using an enum is safer and cleaner than using plain strings.
enum LicenseType {
  none,
  local,
  international,
  both,
}

@embedded
class PersonalInfo {
  final String name;
  final String jobTitle;
  final String email;
  final String summary;
  final String? phone;
  final String? address;
  final String? profileImagePath;

  final DateTime? birthDate;
  final String? maritalStatus;
  final String? militaryServiceStatus;

  /// ✅ NEW: Flag to indicate if the user has a license. Defaults to false.
  final bool hasDriverLicense;

  /// ✅ NEW: Field to store the type of license.
  @Enumerated(EnumType.name)
  final LicenseType licenseType;

  PersonalInfo({
    this.name = '',
    this.jobTitle = '',
    this.email = '',
    this.summary = '',
    this.phone = '',
    this.address = '',
    this.profileImagePath,
    this.birthDate,
    this.maritalStatus,
    this.militaryServiceStatus,
    // Initialize new fields with default values.
    this.hasDriverLicense = false,
    this.licenseType = LicenseType.none,
  });

  PersonalInfo copyWith({
    String? name,
    String? jobTitle,
    String? email,
    String? summary,
    String? phone,
    String? address,
    String? profileImagePath,
    DateTime? birthDate,
    String? maritalStatus,
    String? militaryServiceStatus,
    bool? hasDriverLicense,
    LicenseType? licenseType,
  }) {
    return PersonalInfo(
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      email: email ?? this.email,
      summary: summary ?? this.summary,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      birthDate: birthDate ?? this.birthDate,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      militaryServiceStatus:
          militaryServiceStatus ?? this.militaryServiceStatus,
      hasDriverLicense: hasDriverLicense ?? this.hasDriverLicense,
      licenseType: licenseType ?? this.licenseType,
    );
  }
}
