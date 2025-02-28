import 'package:doctor_perro_helper/models/providers/streams/user_data_provider_stream.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/screens/pages/settings/settings.dart';
import 'package:doctor_perro_helper/utils/extensions/user_role_extensions.dart';
import 'package:doctor_perro_helper/utils/google/google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageAccount extends ConsumerWidget {
  const ManageAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    AsyncValue<UserData> userDataStream = ref.watch(userDataProvider);

    return userDataStream.when(
      data: (UserData data) => ListTile(
        leading: CircleAvatar(
          foregroundImage: NetworkImage(
            data.user?.photoURL ?? "",
          ),
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.surface,
        ),
        trailing: const IconButton(
          tooltip: "Cerrar Sesión",
          onPressed: signOutWithGoogle,
          icon: Icon(Icons.exit_to_app),
        ),
        title: Text(data.document?.displayName ?? "No display Name"),
        subtitle: Text(data.document?.role.translate() ?? ""),
      ),
      error: (Object e, StackTrace st) => const SettingButton(
        onTap: signInWithGoogle,
        child: ListTile(
          leading: Icon(Icons.account_circle_outlined),
          title: Text("No ha iniciado sesión"),
        ),
      ),
      loading: () => const ListTile(
        leading: CircularProgressIndicator(),
        title: Text("Cargando..."),
      ),
    );
  }
}
