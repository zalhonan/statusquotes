import 'package:easy_localization/easy_localization.dart';

// Обработка "вдохновляющих" цитат
String categoryInspired(String categoryName) {
  if (categoryName != "inspirational") {
    return 'usualCategory'.tr() + categoryName;
  } else {
    return 'inspirationalCategory'.tr();
  }
}
