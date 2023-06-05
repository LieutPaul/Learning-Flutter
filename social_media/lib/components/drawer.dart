import 'package:flutter/material.dart';
import 'package:social_media/components/list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  const MyDrawer({super.key, this.onProfileTap, this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          children: [
            const DrawerHeader(
                child: Icon(Icons.lock, color: Colors.white, size: 60)),
            CustomListTile(
              icon: Icons.home,
              text: "H O M E",
              onTap: () => Navigator.pop(context),
            ),
            CustomListTile(
              icon: Icons.person,
              text: "P R O F I L E",
              onTap: onProfileTap,
            ),
            CustomListTile(
              icon: Icons.logout,
              text: "L O G O U T",
              onTap: onSignOut,
            )
          ],
        ));
  }
}
