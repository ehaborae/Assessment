import 'package:demo/core/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';

import 'end_points.dart';
import 'local/cache_helper.dart';

abstract class Repository {
  Future<Response> getNextLaunchRepo();

  Future<Response> getPastLaunchesRepo();

  Future<Response> getLaunchRepo({required String id});

  Future<Response> getRocketRepo({required String id});

  Future<Response> getPayloadsRepo({required String id});
}

class RepoImplementation extends Repository {
  final DioHelper dioHelper;
  final CacheHelper cacheHelper;

  RepoImplementation({
    required this.dioHelper,
    required this.cacheHelper,
  });

  @override
  Future<Response> getNextLaunchRepo() async {
    return await dioHelper.get(
      url: nextLaunchesUrl,
    );
  }

  @override
  Future<Response> getPastLaunchesRepo() async {
    return await dioHelper.get(
      url: pastLaunchesUrl,
    );
  }

  @override
  Future<Response> getLaunchRepo({required String id}) async {
    return await dioHelper.get(
      url: '$launchUrl/$id',
    );
  }

  @override
  Future<Response> getRocketRepo({required String id}) async {
    return await dioHelper.get(
      url: '$rocketUrl/$id',
    );
  }

  @override
  Future<Response> getPayloadsRepo({required String id}) async {
    return await dioHelper.get(
      url: '$payloadsUrl/$id',
    );
  }
}
