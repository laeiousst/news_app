import 'package:envied/envied.dart';

part 'app_env.g.dart';

@Envied(path: '.env', useConstantCase: true)
final class AppEnv {
  @EnviedField()
  static const String serviceUrl = _AppEnv.serviceUrl;
  @EnviedField(obfuscate: true)
  static String rapidKey = _AppEnv.rapidKey;
}
