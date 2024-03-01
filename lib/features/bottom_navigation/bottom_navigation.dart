import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz_posts_app/features/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/screens/list_posts_screen.dart';
import 'package:ninjaz_posts_app/features/tab2/tab2_screen.dart';
import 'package:ninjaz_posts_app/features/tab3/tab3_screen.dart';

/// A widget that manages the bottom navigation bar.
///
/// This widget is responsible for managing the state of the bottom navigation
/// bar and updating it accordingly. It uses a [BlocConsumer] widget to listen
/// for changes in the [BottomNavigationBloc] and rebuild the widget tree
/// accordingly.
class BottomNavigation extends StatelessWidget {
  /// Creates a [BottomNavigation] widget.
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
              children: const [
                ListOfPostsScreen(),
                Tab2Screen(),
                Tab3Screen(),
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

/// A list of [BottomNavigationBarItem]s that are used as the items in the
/// bottom navigation bar.
const List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
  /// An icon with the [Icons.list] glyph and the label 'Posts'.
  BottomNavigationBarItem(
    icon: Icon(Icons.list),
    label: 'Posts',
  ),

  /// An icon with the [Icons.tab] glyph and the label 'Tab 2'.
  BottomNavigationBarItem(
    icon: Icon(Icons.tab),
    label: 'Tab 2',
  ),

  /// An icon with the [Icons.table_chart_outlined] glyph and the label 'Tab 3'.
  BottomNavigationBarItem(
    icon: Icon(Icons.table_chart_outlined),
    label: 'Tab 3',
  ),
];
