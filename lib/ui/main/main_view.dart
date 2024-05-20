import 'package:appjamgrup51/pages/ai_page/ai_view.dart';
import 'package:appjamgrup51/pages/profile_page/profile_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) {
            setState(() {
              currentPageIndex = value;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home),
                label: "AnaSayfa"),
            NavigationDestination(
                icon: Icon(Icons.alt_route_rounded),
                label: "Bilgi Paylaşımı"),
            NavigationDestination(
                icon: Icon(Icons.person),
                label: "Profil"),

          ],
        ),
        body: <Widget>[
          Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: SizedBox.expand(
              child: Center(
                child: Text(
                  'Home page',
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
          ),
           AIView(),
          ProfileView()


        ][currentPageIndex]
    );
  }
}
