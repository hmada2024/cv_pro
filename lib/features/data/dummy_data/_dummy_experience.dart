// features/pdf_export/data/dummy_data/_dummy_experience.dart
part of 'cv_data_dummy.dart';

List<Experience> _createDummyExperiences() {
  return [
    Experience.create(
      position: 'Senior Graphic Designer',
      companyName: 'Fauget Studio',
      startDate: DateTime(2020, 1, 1),
      description:
          '• Led the design of a major rebranding project for a key client, resulting in a 25% increase in brand engagement.\n• Mentored a team of junior designers, improving team productivity and skill level.\n• Developed and executed visual concepts for digital marketing campaigns across multiple platforms.\n• Collaborated with marketing teams to create compelling visuals for social media, email, and web content.',
    ),
    Experience.create(
      position: 'Graphic Designer',
      companyName: 'Iarana, Inc',
      startDate: DateTime(2017, 1, 1),
      endDate: DateTime(2019, 12, 1),
      description:
          '• Created over 100 graphic designs for various clients, including logos, brochures, and website assets.\n• Worked closely with clients to understand their needs and deliver designs that met their objectives.\n• Managed multiple design projects simultaneously, ensuring timely delivery and high-quality results.\n• Contributed to brainstorming sessions and creative development processes.',
    ),
    Experience.create(
      position: 'Junior Designer',
      companyName: 'Creative Minds Agency',
      startDate: DateTime(2015, 6, 1),
      endDate: DateTime(2016, 12, 1),
      description:
          '• Assisted senior designers with various design tasks, including image editing and layout adjustments.\n• Prepared final design files for print and digital production.\n• Gained hands-on experience with industry-standard design software and workflows.',
    ),
  ];
}
