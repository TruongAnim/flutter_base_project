import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter_base_project/constants/app_const.dart';

class PerformanceService {
  PerformanceService._();
  static final PerformanceService _instance = PerformanceService._();
  static PerformanceService get instance => _instance;
  static PerformanceService get I => _instance;

  static const String sCanTrust = 'can_trust';
  static const String sBuildType = 'build_type';
  static const String sTrue = 'true';
  static const String sFalse = 'false';

  // events
  static const String loadVideoEvent = 'load_video_time';

  static const int maxTime = 10000;
  final Map<String, Trace> _trace = {};

  Future<void> init() async {
    FirebasePerformance.instance.setPerformanceCollectionEnabled(true);
  }

  void startTrace({
    required String key,
    required String eventName,
  }) {
    final trace = FirebasePerformance.instance.newTrace(eventName);
    _trace[key] = trace;
    trace.start();
  }

  void stopTrace({
    required String key,
    bool canTrust = true,
  }) {
    if (_trace.containsKey(key)) {
      final trace = _trace[key]!;

      trace.putAttribute(sCanTrust, canTrust ? sTrue : sFalse);
      trace.putAttribute(sBuildType, AppConst.buildType.name);
      trace.stop();
      _trace.remove(key);
    }
  }
}
