import 'date_time_util.dart';

class RuntimeResult<T> {
  final T result;
  final int startTime;
  final int executionTime;

  RuntimeResult({
    required this.result,
    required this.startTime,
    required this.executionTime,
  });

  @override
  String toString() {
    return 'Result(result: $result, startTime: $startTime, executionTime: $executionTime ms)';
  }
}

mixin RuntimeUtil {
  static int appStart = DateTimeUtil.timeStamp;
  static int blockThreadTime = 0;
  static get appRunTime => DateTimeUtil.timeStamp - blockThreadTime - appStart;

  Future<RuntimeResult<T>> measureAsync<T>(Future<T> Function() asyncFunction,
      {bool isBlockThread = false}) async {
    // Get the start time
    final start = DateTimeUtil.timeStamp;

    // Execute the asynchronous function
    T result = await asyncFunction();
    if (isBlockThread) {
      blockThreadTime += DateTimeUtil.timeStamp - start;
    }

    // Return a Result object
    return RuntimeResult<T>(
      result: result,
      startTime: start,
      executionTime: DateTimeUtil.timeStamp - start,
    );
  }
}
