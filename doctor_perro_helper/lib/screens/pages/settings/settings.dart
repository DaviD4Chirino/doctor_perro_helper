import 'dart:developer';

import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/screens/pages/settings/change_dolar_price.dart';
import 'package:doctor_perro_helper/utils/extensions/user_role_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: Sizes().xxl,
          horizontal: Sizes().large,
        ),
        children: [
          Text(
            "Cuenta",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Account(),
          Text(
            "Ajustes",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SettingButton(
            child: const ListTile(
              title: Text("Precio del dolar"),
              leading: Icon(Icons.attach_money),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => const ChangeDolarPrice(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({super.key, required this.child, required this.onTap});

  final Widget child;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(70),
      child: Column(
        children: [
          child,
          Container(
            height: 1.0,
            color:
                Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(100),
          )
        ],
      ),
    );
  }
}

class Account extends ConsumerStatefulWidget {
  const Account({super.key});

  @override
  ConsumerState<Account> createState() => _AccountState();
}

class _AccountState extends ConsumerState<Account> {
  bool isLoading = false;

  Future<void> handleTap() async {
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
