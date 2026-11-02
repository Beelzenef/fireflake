import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/app_cubit.dart';

Future<bool> saveProjectWithFeedback(
  BuildContext context, {
  VoidCallback? update,
  required String successMessage,
}) async {
  final cubit = context.read<AppCubit>();
  final messenger = ScaffoldMessenger.of(context);
  try {
    update?.call();
    await cubit.saveCurrentProjectToDisk();
  } catch (error, stackTrace) {
    debugPrint('Error saving project: $error\n$stackTrace');
    if (context.mounted) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not save project: $error')),
      );
    }
    return false;
  }
  if (context.mounted) {
    messenger.showSnackBar(SnackBar(content: Text(successMessage)));
  }
  return true;
}
