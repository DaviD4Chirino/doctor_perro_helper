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
    print("AUTH STATE HERE----> ");
  }

  bool isLoading = false;

  Future<void> handleTap() async {
    if (ref.watch(userNotifierProvider).isEmpty == false) {
      return;
    }
    await signIn();
  }

  Future<void> signIn() async {
    setState(() {
      isLoading = true;
    });
    await signInWithGoogle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserData userData = ref.watch(userNotifierProvider);
    ThemeData theme = Theme.of(context);

    AsyncValue<User?> userStream = ref.watch(authStateChangesProvider);

    String titleString = userStream.when(
        data: (data) => data?.displayName ?? "No ha iniciado sesión",
        error: (e, st) => "Error iniciando sesión",
        loading: () => "Cargando...");

    var leading = userData.credential != null
        ? CircleAvatar(
            foregroundImage: NetworkImage(
              userData.credential?.user?.photoURL ?? "",
            ),
            backgroundColor: theme.colorScheme.surface,
            foregroundColor: theme.colorScheme.surface,
          )
        : const Icon(Icons.account_circle_outlined);
    // final avatar = CircleAvatar()

    return SettingButton(
      onTap: handleTap,
      child: ListTile(
        leading: isLoading ? const CircularProgressIndicator() : leading,
        trailing: userData.credential != null
            ? const IconButton(
                tooltip: "Cerrar Sesión",
                onPressed: signOutWithGoogle,
                icon: Icon(Icons.exit_to_app))
            : null,
        title: Text(titleString),
        subtitle: userData.document != null
            ? Text(userData.document?.role?.translate() ?? "")
            : null,
      ),
    );
  }
}
