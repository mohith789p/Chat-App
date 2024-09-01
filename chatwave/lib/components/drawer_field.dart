import 'package:chatwave/services/auth/auth_service.dart';
import 'package:chatwave/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    // get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // logo
                DrawerHeader(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
                // home list
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      title: const Text('H O M E'),
                      leading: const Icon(Icons.home),
                      onTap: () {
                        // go to home screen by popping the drawer
                        Navigator.pop(context);
                      },
                    )),
                // settings
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    title: const Text('S E T T I N G S'),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      // pop the drawer
                      Navigator.pop(context);
                      // go to settings page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // log out
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: ListTile(
                title: const Text('S I G N O U T'),
                leading: const Icon(Icons.logout),
                onTap: logout,
              ),
            ),
          ],
        ));
  }
}
