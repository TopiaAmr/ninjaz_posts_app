import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz_posts_app/features/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/screens/list_posts_screen.dart';
import 'package:ninjaz_posts_app/features/tab2/tab2_screen.dart';
import 'package:ninjaz_posts_app/features/tab3/tab3_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: state.tabIndex,
              children: [
                const ListOfPostsScreen(),
                const Tab2Screen(),
                const Tab3Screen(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            currentIndex: state.tabIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              BlocProvider.of<BottomNavigationBloc>(context).add(
                TabChange(
                  tabIndex: index,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

const List<BottomNavigationBarItem> bottomNavItems =
    const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.list),
    label: 'Posts',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.tab),
    label: 'Tab 2',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.table_chart_outlined),
    label: 'Tab 3',
  ),
];
