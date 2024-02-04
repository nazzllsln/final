import 'package:flutter/material.dart';
import 'package:nazliii/screens/loginscreen.dart';
import 'package:nazliii/widgets/MenuItem.dart';
import 'package:nazliii/widgets/ProfileItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Posta Uygulaması'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Gelen Kutusu'),
            Tab(text: 'Gönderilenler'),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ProfileItem(
              name: "Nazlı Aslan",
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            Divider(),
            Expanded(
              child: Column(
                children: [
                  MenuItem(
                    title: "Home Screen",
                    icon: Icon(
                      Icons.home,
                      size: 30,
                    ),
                    onTap: () {},
                  ),
                  MenuItem(
                    title: "About us",
                    icon: Icon(
                      Icons.info_outline,
                      size: 30,
                    ),
                    onTap: () {},
                  ),
                  MenuItem(
                    title: "İletişim",
                    icon: Icon(
                      Icons.message_outlined,
                      size: 30,
                    ),
                    onTap: () {},
                  ),
                  Divider(),
                  MenuItem(
                    title: "Ayarlar",
                    icon: Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/settings");
                    },
                  ),
                  Divider(),
                  MenuItem(
                    icon: Icon(Icons.logout_outlined),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                    title: "Sign out",
                  ),
                ],
              ),
            ),
            Text(
              "Version 1.0.7",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MailList(isInbox: true),
          MailList(isInbox: false),
        ],
      ),
    );
  }
}

class MailList extends StatelessWidget {
  final bool isInbox;

  const MailList({Key? key, required this.isInbox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(isInbox ? 'Gelen Kutusu' : 'Gönderilenler'),
    );
  }
}
