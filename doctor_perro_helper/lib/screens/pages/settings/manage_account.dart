import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/screens/pages/settings/settings.dart';
import 'package:doctor_perro_helper/utils/extensions/user_role_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageAccount extends ConsumerStatefulWidget {
  const ManageAccount({super.key});

  @override
  ConsumerState<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends ConsumerState<ManageAccount> {
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
    await ref.read(userNotifierProvider.notifier).googleSignIn();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserData userData = ref.watch(userNotifierProvider);
    ThemeData theme = Theme.of(context);
    String titleString =
        (userData.document?.displayName ?? "No estás registrado");
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
            ? IconButton(
                tooltip: "Cerrar Sesión",
                onPressed:
                    ref.read(userNotifierProvider.notifier).googleSignOut,
                icon: const Icon(Icons.exit_to_app))
            : null,
        title: Text(titleString),
        subtitle: userData.document != null
            ? Text(userData.document?.role?.translate() ?? "")
            : null,
      ),
    );
  }
}
