import 'package:taska/core/cache/cache_helper.dart';
import 'package:taska/core/cache/cache_keys_values.dart';
import 'package:taska/core/database/database.dart';
import 'package:taska/features/profile/data/datasources/profile_local_data_source/profile_local_data_source.dart';

class ProfileLocalDataSourceImpl extends ProfileLocalDataSource {
  @override
  Future<void> deleteAccount() async {
    clearDatabase();
    await CacheData.removeData(key: CacheKeys.kDATE);
    await CacheData.removeData(key: CacheKeys.kSECONDS);
  }
}
