// ignore: file_names
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputsFormatter {
  static MaskTextInputFormatter phoneMaskFormatter = MaskTextInputFormatter(
      mask: '+#############', type: MaskAutoCompletionType.lazy);
}
