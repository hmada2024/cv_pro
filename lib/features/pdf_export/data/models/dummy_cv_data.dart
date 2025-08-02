// features/pdf_export/data/models/dummy_cv_data.dart

import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

CVData createDummyCvData() {
  return CVData(
    personalInfo: PersonalInfo(
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
        militaryServiceStatus: 'Completed'),
    experiences: [
      Experience.create(
        position: 'Senior Graphic Designer',
        companyName: 'Fauget Studio',
        startDate: DateTime(2020, 1, 1),
        description:
            '• create more than 100 graphic designs for big companies\n• complete a lot of complicated work',
      ),
      Experience.create(
        position: 'Graphic Designer',
        companyName: 'Iarana, Inc',
        startDate: DateTime(2017, 1, 1),
        endDate: DateTime(2019, 12, 31),
        description:
            '• create more than 100 graphic designs for big companies\n• complete a lot of complicated work',
      ),
    ],
    education: [
      Education.create(
        level: EducationLevel.master,
        degreeName: 'of Graphic Design',
        school: 'Arts University',
        startDate: DateTime(2015, 9, 1),
        endDate: DateTime(2017, 6, 30),
      ),
      Education.create(
        level: EducationLevel.bachelor,
        degreeName: 'of Fine Arts',
        school: 'Wardiere University',
        startDate: DateTime(2011, 9, 1),
        endDate: DateTime(2015, 6, 30),
      ),
    ],
    skills: [
      Skill.create(name: 'Web Design', level: 'Advanced'),
      Skill.create(name: 'Branding', level: 'Advanced'),
      Skill.create(name: 'Graphic Design', level: 'Expert'),
      Skill.create(name: 'SEO', level: 'Upper-Intermediate'),
      Skill.create(name: 'Marketing', level: 'Advanced'),
    ],
    languages: [
      Language.create(name: 'English', proficiency: 'Expert'),
      Language.create(name: 'French', proficiency: 'Advanced'),
    ],
    references: [
      Reference.create(
        name: 'Dr. Jane Doe',
        company: 'Fauget Studio',
        position: 'Art Director',
        email: 'jane.doe@fauget.com',
        phone: '+098-765-4321',
      ),
    ],
  );
}
