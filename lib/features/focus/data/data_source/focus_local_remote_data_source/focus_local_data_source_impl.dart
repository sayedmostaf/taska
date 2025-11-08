import 'package:taska/core/cache/cache_helper.dart';
import 'package:taska/core/cache/cache_keys_values.dart';
import 'package:taska/features/focus/data/data_source/focus_local_remote_data_source/focus_local_data_source.dart';

class FocusLocalDataSourceImpl extends FocusLocalDataSource {
  @override
  Future<void> addTimeForToday(int seconds) async {
    String? cachedDate = CacheData.getData(key: CacheKeys.kDATE);
    if (cachedDate != null) {
      DateTime date = DateTime.parse(cachedDate);
      if (date.day == DateTime.now().day &&
          date.month == DateTime.now().month &&
          date.year == DateTime.now().year) {
        await CacheData.setData(
          key: CacheKeys.kSECONDS,
          value: CacheData.getData(key: CacheKeys.kSECONDS) + seconds,
        );
      } else {
        await CacheData.setData(
          key: CacheKeys.kDATE,
          value: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).toIso8601String(),
        );
        await CacheData.setData(key: CacheKeys.kSECONDS, value: seconds);
      }
    } else {
      await CacheData.setData(
        key: CacheKeys.kDATE,
        value: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ).toIso8601String(),
      );
      await CacheData.setData(key: CacheKeys.kSECONDS, value: seconds);
    }
  }

  @override
  int? getTimeForToday() {
    String? cachedDate = CacheData.getData(key: CacheKeys.kDATE);
    if (cachedDate != null) {
      DateTime date = DateTime.parse(cachedDate);
      if (date.day == DateTime.now().day &&
          date.month == DateTime.now().month &&
          date.year == DateTime.now().year) {
        return CacheData.getData(key: CacheKeys.kSECONDS);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
