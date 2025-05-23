import 'dart:async';

class StopwatchTimer {
  int _elapsedMs = 0;
  Timer? _timer;

  void start(void Function() onTick) {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
      _elapsedMs += 1000;
      onTick();
    });
  }

  void stop() => _timer?.cancel();

  String get formatted {
    final seconds = (_elapsedMs ~/ 1000) % 60;
    final minutes = (_elapsedMs ~/ 60000);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
