import 'package:injectable/injectable.dart';

@singleton
class ThirdPartyModeEnv {
  late ModeEnv modeEnv;
}

enum ModeEnv { development, staging, production }
