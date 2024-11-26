import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'flavors.dart';

import 'gen/assets.gen.dart';
import 'main.dart' as runner;

Future<void> main() async {
  await dotenv.load(fileName: Assets.lib.flavors.aEnvProd);
  await runner.main();
}
