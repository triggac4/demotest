import 'package:demotest/models/scheduledDateModel.dart';
import "package:flutter/material.dart";

class ScheduledDateProvider extends InheritedWidget {
  ScheduledDateProvider({required this.schedule, required this.child}) : super(child: child);
  late final AllScheduledDate schedule;
  late final Widget child;
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static AllScheduledDate of(BuildContext context) {
    final ScheduledDateProvider provider =
        context.dependOnInheritedWidgetOfExactType<ScheduledDateProvider>(
            aspect: ScheduledDateProvider)!;
    return provider.schedule;
  }
}
