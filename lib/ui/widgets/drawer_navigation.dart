import 'package:flutter/material.dart';
import 'package:todo_list/ui/pages/categories_page.dart';
import 'package:todo_list/ui/pages/home_screen_page.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://asset.kompas.com/crops/AOqycoSV_pH5eU51rYStWW_zVFY=/1x0:1000x666/750x500/data/photo/2019/11/04/5dbfff829ebe6.jpg'),
            ),
            accountName: Text('Muhamad Agus'),
            accountEmail: Text('muhamadagus@gmail.com'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.maybePop(context),
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('Categories'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CategoriesPage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
