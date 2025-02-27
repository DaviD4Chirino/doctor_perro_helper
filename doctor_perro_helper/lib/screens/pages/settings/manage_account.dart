import 'dart:developer';

import 'package:doctor_perro_helper/models/providers/streams/user_data_provider_stream.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/screens/pages/settings/settings.dart';
import 'package:doctor_perro_helper/utils/extensions/user_role_extensions.dart';
import 'package:doctor_perro_helper/utils/google/google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageAccount extends ConsumerStatefulWidget {
  const ManageAccount({super.key});

  @override
  ConsumerState<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends ConsumerState<ManageAccount> {
  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;

  Future<void> handleTap() async {
    if (ref.watch(userNotifierProvider).isEmpty == false) {
      return;
    }
    await signIn();
  }

  Future<void> signIn() async {
    /* setState(() {
      isLoading = true;
    }); */
    await signInWithGoogle();
    /* setState(() {
      isLoading = false;
    }); */
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<UserData> userDataStream = ref.watch(userDataProvider);
    ThemeData theme = Theme.of(context);
    //TODO: rework all this so only on when is used
    String titleString = userDataStream.when(
        data: (data) => data.document?.displayName ?? "No display Name",
        error: (e, st) => "No ha iniciado sesión",
        loading: () => "Cargando...");

    Widget leading = userDataStream.when(
      data: (UserData data) => CircleAvatar(
        foregroundImage: NetworkImage(
          data.user?.photoURL ?? "",
        ),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.surface,
      ),
      error: (e, st) => const Icon(Icons.account_circle_outlined),
      loading: () => const CircularProgressIndicator(),
    );

    Widget? trailing = userDataStream.when(
      data: (UserData data) => const IconButton(
        tooltip: "Cerrar Sesión",
        onPressed: signOutWithGoogle,
        icon: Icon(Icons.exit_to_app),
      ),
      loading: () => null,
      error: (e, st) => null,
    );

    Widget? subtitle = userDataStream.whenOrNull(
      data: (UserData data) => Text(data.document?.role.translate() ?? ""),
    );
    // var _leading = userData.credential != null
    //     ? CircleAvatar(
    //         foregroundImage: NetworkImage(
    //           userData.credential?.user?.photoURL ?? "",
    //         ),
    //         backgroundColor: theme.colorScheme.surface,
    //         foregroundColor: theme.colorScheme.surface,
    //       )
    //     : const Icon(Icons.account_circle_outlined);
    // final avatar = CircleAvatar()

    return SettingButton(
      onTap: handleTap,
      child: ListTile(
        leading: isLoading ? const CircularProgressIndicator() : leading,
        trailing: trailing,
        title: Text(titleString),
        subtitle: subtitle,
      ),
    );
  }
}
