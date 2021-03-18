import 'package:mobx/mobx.dart';
import '../models/models.dart';
import '../services/constants.dart';
part 'background_store.g.dart';

// запуск на кодогенерацию:
// flutter pub run build_runner build --delete-conflicting-outputs

class _BackgroundImpl extends BackgroundStore with _$_BackgroundImpl {}

abstract class BackgroundStore with Store {
  factory BackgroundStore.create() => _BackgroundImpl();
  BackgroundStore();

  // обычный List не уведомляет MobX об измнениях, используем ObservableList
  ObservableList<BackgroundPicture> backgroundsList = ObservableList();

  @action
  void setBackgrounds(List<BackgroundPicture> newBackgrounds) {
    backgroundsList = ObservableList();
    for (BackgroundPicture background in newBackgrounds) {
      if (kAllowedbackgrounds.contains(background.id)) {
        backgroundsList.add(background);
      }
    }
  }
}
