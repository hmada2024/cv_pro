// lib/features/3_cv_presentation/pdf_generation/layout/pdf_template_layout_contract.dart
import 'package:pdf/widgets.dart' as pw;

/// A contract (abstract class) that all PDF template layouts must adhere to.
///
/// This ensures that every template is a self-contained unit that not only
/// knows how to build itself but also defines its own page margin requirements.
/// This approach adheres to the Single Responsibility and Open/Closed principles.
abstract class PdfTemplateLayout extends pw.StatelessWidget {
  /// The specific page margin required by this template layout.
  ///
  /// For example, a template that needs to be borderless would return
  /// `pw.EdgeInsets.zero`, while a classic template might return
  /// `const pw.EdgeInsets.all(30)`.
  abstract final pw.EdgeInsets margin;
}
