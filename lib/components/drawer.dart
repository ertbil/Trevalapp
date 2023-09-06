import 'package:flutter/material.dart';

import '../util/route_animator.dart';
import '../pages/login_screen.dart';
import '../pages/setting_page.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("User Name",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: () {
              Navigator.of(context).push(createRoute(const LogInPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).push(createRoute(const SettigPage()));
            },
          ),
        ],
      ),
    );
  }
}
