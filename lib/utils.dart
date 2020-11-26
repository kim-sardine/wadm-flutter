import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


// 1 ~ 10
class FromOneToTenTextInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    else if (int.parse(newValue.text) > 10) {
      return TextEditingValue(
        text: '10',
        selection: TextSelection.collapsed(offset: 2),
      );
    }
    else if (int.parse(newValue.text) < 1) {
      return TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    return newValue;
  }
}

List<TextInputFormatter> categoryWeightInputFormatter = <TextInputFormatter>[
  FilteringTextInputFormatter.digitsOnly,
  FromOneToTenTextInputFormatter(),
];

String convertDateTimeToString(DateTime dt) {
  return DateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
}

DateTime convertStringToDateTime(String dt) {
  return new DateFormat("yyyy-MM-dd HH:mm:ss").parse(dt, true);
}

DateTime removeMiliMicroSeconds(DateTime dt) {
  return dt.subtract(new Duration(microseconds: dt.microsecond, milliseconds: dt.millisecond));
}

DateTime getUtcNow() {
  return new DateTime.now().toUtc();
}
