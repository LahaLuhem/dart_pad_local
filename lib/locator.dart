import 'dart:async';

import 'package:dart_pad_local/services/execution_service.dart';
import 'package:dart_pad_local/services/file_io_service.dart';
import 'package:dart_pad_local/views/home_view_model.dart';
import 'package:get_it/get_it.dart';

/// Locates dependency for DI
GetIt get locate => Locator.instance();

/// Dependency Injection
class Locator {
  /// Instance of [GetIt]
  static GetIt instance() => GetIt.instance;

  /// Callback for performing a DI lookup
  static T locate<T extends Object>() => instance().get<T>();

  /// Set up of all DI registrations
  static Future<void> setup() async {
    final locator = instance();

    _registerAPIs(locator);
    await _registerServices(locator);
    _registerViewModels(locator);
  }

  static void _registerAPIs(GetIt it) {}

  static Future<void> _registerServices(GetIt it) async {
    it
      ..registerSingleton(FileIOService())
      ..registerLazySingleton(
        () => ExecutionService(
          fileIOService: FileIOService.locate,
        ),
      );
  }

  static void _registerViewModels(GetIt it) {
    it.registerFactory(
      () => HomeViewModel(
        fileIOService: FileIOService.locate,
        executionService: ExecutionService.locate,
      ),
    );
  }
}
