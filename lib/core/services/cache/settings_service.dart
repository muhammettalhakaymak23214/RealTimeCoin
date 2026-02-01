import 'package:hive/hive.dart';

class SettingsService {
  static final Box _box = Hive.box('settings');
  static const String _gridKey = 'is_grid_view';

  static bool isGridView() => _box.get(_gridKey, defaultValue: false);

  static Future<void> setGridView(bool value) async {
    await _box.put(_gridKey, value);
  }
}