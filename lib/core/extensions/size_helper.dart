import 'package:flutter/widgets.dart';

extension SizeHelper on num {
  SizedBox get h => SizedBox(height: this.toDouble());
  SizedBox get w => SizedBox(width: this.toDouble());
  EdgeInsets get all => EdgeInsets.all(this.toDouble());
}
