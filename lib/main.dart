import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/ui/screens/cv_form_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  // تأكد من تهيئة Flutter قبل تشغيل أي كود أصلي
  WidgetsFlutterBinding.ensureInitialized();

  // احصل على مسار لتخزين قاعدة البيانات
  final dir = await getApplicationDocumentsDirectory();

  // افتح قاعدة بيانات Isar
  final isar = await Isar.open(
    [CVDataSchema], // أخبر Isar عن الـ collections التي ستستخدمها
    directory: dir.path,
  );

  runApp(
    ProviderScope(
      // هنا نقوم بتوفير نسخة Isar الفعلية للتطبيق
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme),
          appBarTheme: AppBarTheme(
            titleTextStyle:
                GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          )),
      home: const CvFormScreen(),
    );
  }
}
