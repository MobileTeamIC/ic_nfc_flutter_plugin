import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// context extension
extension ContextExtension on BuildContext {
  ShadTextTheme get textTheme => ShadTheme.of(this).textTheme;
  ShadColorScheme get colorScheme => ShadTheme.of(this).colorScheme;

  
  ShadThemeData get theme => ShadTheme.of(this);
  double get top_padding => MediaQuery.of(this).padding.top;
  double get bottom_padding => MediaQuery.of(this).padding.bottom;
  double get left_padding => MediaQuery.of(this).padding.left;
  double get right_padding => MediaQuery.of(this).padding.right;
  EdgeInsets get sm_padding => const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  EdgeInsets get md_padding => const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
  EdgeInsets get lg_padding => const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
  EdgeInsets get xl_padding => const EdgeInsets.symmetric(horizontal: 40, vertical: 20);

  BorderRadius get sm_border_radius => BorderRadius.circular(8);
  BorderRadius get md_border_radius => BorderRadius.circular(12);
  BorderRadius get lg_border_radius => BorderRadius.circular(16);

  // context width screen
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

}