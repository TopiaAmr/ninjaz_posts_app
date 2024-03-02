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

  group('Bottom Sheet Navigation', () {
    testWidgets('Testing Bottom Sheet Navigation', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(BottomNavigation), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(BottomNavigation), findsOneWidget);
      expect(find.byType(ListOfPostsScreen), findsOneWidget);
      expect(find.byType(Tab2Screen), findsNothing);
      expect(find.byType(Tab3Screen), findsNothing);
      await tester.tap(find.text('Tab 2'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomNavigation), findsOneWidget);
      expect(find.byType(ListOfPostsScreen), findsNothing);
      expect(find.byType(Tab2Screen), findsOneWidget);
      expect(find.byType(Tab3Screen), findsNothing);
      expect(find.text('Coming Soon'), findsOneWidget);
      await tester.tap(find.text('Tab 3'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomNavigation), findsOneWidget);
      expect(find.byType(ListOfPostsScreen), findsNothing);
      expect(find.byType(Tab2Screen), findsNothing);
      expect(find.byType(Tab3Screen), findsOneWidget);
      expect(find.text('Coming Soon'), findsOneWidget);
    });
  });

  group('Testing Posts List', () {
    testWidgets('Testing Posts List', (tester) async {
      app.main();
      await tester.pumpAndSettle();
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
    });
  });
}
