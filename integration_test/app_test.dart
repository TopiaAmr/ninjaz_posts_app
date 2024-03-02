import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ninjaz_posts_app/features/bottom_navigation/bottom_navigation.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/screens/list_posts_screen.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/widgets/post_item_widget.dart';
import 'package:ninjaz_posts_app/features/tab2/tab2_screen.dart';
import 'package:ninjaz_posts_app/features/tab3/tab3_screen.dart';
import 'package:ninjaz_posts_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  /// Tests the main functionality of the app, including interactions with
  /// the bottom navigation bar, switching between tabs, and scrolling the posts list.
  testWidgets(
    'End to end testing',
    (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(BottomNavigation), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(BottomNavigation), findsOneWidget);
      expect(find.byType(ListOfPostsScreen), findsOneWidget);
      expect(find.byType(Tab2Screen), findsNothing);
      expect(find.byType(Tab3Screen), findsNothing);

      /// Taps the "Tab 2" button on the bottom navigation bar.
      await tester.tap(find.text('Tab 2'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomNavigation), findsOneWidget);
      expect(find.byType(ListOfPostsScreen), findsNothing);
      expect(find.byType(Tab2Screen), findsOneWidget);
      expect(find.byType(Tab3Screen), findsNothing);
      expect(find.text('Coming Soon'), findsOneWidget);
      
      /// Taps the "Tab 3" button on the bottom navigation bar.
      await tester.tap(find.text('Tab 3'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomNavigation), findsOneWidget);
      expect(find.byType(ListOfPostsScreen), findsNothing);
      expect(find.byType(Tab2Screen), findsNothing);
      expect(find.byType(Tab3Screen), findsOneWidget);
      expect(find.text('Coming Soon'), findsOneWidget);
      
      /// Taps the "Posts" button on the bottom navigation bar.
      await tester.tap(find.text('Posts'));
      await tester.pumpAndSettle();

      /// Simulates a swipe down gesture to scroll the posts list.
      /// Finds multiple 'PostItemWidget' instances, verifying that posts are loaded and displayed correctly.
      final gesture = await tester.startGesture(Offset(0, 300));
      await gesture.moveBy(Offset(0, -300));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(PostItemWidget), findsWidgets);
      await gesture.moveBy(Offset(0, -300));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(PostItemWidget), findsWidgets);
      await gesture.moveBy(Offset(0, -300));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(PostItemWidget), findsWidgets);
      await gesture.moveBy(Offset(0, -300));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(PostItemWidget), findsWidgets);
      await gesture.moveBy(Offset(0, -300));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(PostItemWidget), findsWidgets);
      await gesture.moveBy(Offset(0, -300));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(PostItemWidget), findsWidgets);
      await tester.pumpAndSettle();
    },
    timeout: const Timeout(
      Duration(minutes: 30),
    ),
  );
}
