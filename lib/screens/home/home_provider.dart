import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier {}

final homeProvider = Provider<HomeNotifier>((ref) => HomeNotifier());
