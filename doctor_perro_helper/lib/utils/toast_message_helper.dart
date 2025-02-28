import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

abstract class ToastMessage {
  static ToastificationItem success({Widget? title, Duration? duration}) =>
      toastification.show(
        title: title,
        autoCloseDuration: duration ?? const Duration(seconds: 2),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        showProgressBar: false,
      );
  static ToastificationItem error({Widget? title, Duration? duration}) =>
      toastification.show(
        title: title,
        autoCloseDuration: duration ?? const Duration(seconds: 2),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        showProgressBar: false,
      );
  static ToastificationItem info({Widget? title, Duration? duration}) =>
      toastification.show(
        title: title,
        autoCloseDuration: duration ?? const Duration(seconds: 2),
        type: ToastificationType.info,
        style: ToastificationStyle.fillColored,
        showProgressBar: false,
      );
  static ToastificationItem warning({Widget? title, Duration? duration}) =>
      toastification.show(
        title: title,
        autoCloseDuration: duration ?? const Duration(seconds: 2),
        type: ToastificationType.warning,
        style: ToastificationStyle.fillColored,
        showProgressBar: false,
      );
}
