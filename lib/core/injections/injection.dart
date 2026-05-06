import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/core/injections/injection.config.dart';

GetIt sl = GetIt.instance;

@InjectableInit(asExtension: false)
void configureDependencies() => init(sl);
