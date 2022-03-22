import 'package:dukka/core/injections/locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt sl = GetIt.instance;

@injectableInit
Future<void> configureDependecies() async => $initGetIt(sl);
