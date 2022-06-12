import '../helper/log_helper.dart';
import 'package:flutter_cache/flutter_cache.dart' as cache;

class CacheService {
  static Future synchronouslyUpdate(
      {required String key,
      required Function() load,
      bool freshData = false}) async {
    try {
      var cachedData = await cache.load(key, null, true);
      if (cachedData != null) {
        logSuccess('Cache existed');
        if (freshData) return await load();
        load();
        return cachedData;
      } else {
        logSuccess('Cache not existed');

        return await load();
      }
    } catch (e) {
      logError('Synchronously update is failed : ${e.toString()} key: $key');
      return e;
    }
  }

  static Future createCache(String key, data) async {
    try {
      if (await cache.load(key) != null) {
        cache.destroy(key);
      }
      return await cache.write(key, data);
    } catch (e) {
      logError('Error create cache : ${e.toString()}');
      rethrow;
    }
  }

  static Future? readCache(String key) async {
    try {
      return await cache.load(key, null, true);
    } catch (e) {
      logError('Error read cache : ${e.toString()}');
      rethrow;
    }
  }

  static Future updateCache(String key, data) async {
    try {
      return await cache.write(key, data);
    } catch (e) {
      logError('Error update cache : ${e.toString()}');
      rethrow;
    }
  }

  static void deleteCache(String key) {
    try {
      cache.destroy(key);
    } catch (e) {
      logError('Error delete cache : ${e.toString()}');
      rethrow;
    }
  }

  static void deleteAll() {
    try {
      cache.clear();
    } catch (e) {
      logError('Error delete all cache : ${e.toString()}');
      rethrow;
    }
  }
}
