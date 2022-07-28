// import 'dart:html';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:menus/models/food.dart';
// import 'package:menus/models/stall.dart';
// import 'package:menus/providers/canteens.dart';
// import 'package:menus/providers/comments.dart';
// import 'package:menus/providers/foods.dart';
// import 'package:menus/providers/stalls.dart';
// import 'package:mocktail/mocktail.dart';

// class MockStalls extends Mock implements Stalls {}

// class MockFoods extends Mock implements Foods {}

// class MockComments extends Mock implements Comments {}

// void main() {
//   late MockStalls mockStalls;
//   late MockFoods mockFoods;
//   late MockComments mockComments;
//   setUp(() {
//     mockStalls = MockStalls();
//     mockFoods = MockFoods();
//   });

//   group('getStalls', () {
//     final stallsFromService = [Stall('test1', 'test1', '', [])];
//     void arrangeStalls() {
//       when(() => mockStalls.fetchAndSetStalls('1'))
//           .thenAnswer((_) async => stallsFromService);
//     }

//     test(
//       'test stalls provider',
//       () async {
//         expect(mockStalls.stalls, []);
//         arrangeStalls();
//         await mockStalls.fetchAndSetStalls('1');
//         verify(() => mockStalls.fetchAndSetStalls('1')).called(1);
//         expect(mockStalls.stalls, stallsFromService);
//       },
//     );
//   });

//   group('getFoods', () {
//     final foodsFromService = [
//       Food(
//           id: 'test2',
//           title: 'test2',
//           description: 'test2',
//           price: 1.0,
//           imageUrl: '')
//     ];
//     void arrangeFoods() {
//       when(() => mockFoods.fetchAndSetFoods('1', '2'))
//           .thenAnswer((_) async => foodsFromService);
//     }

//     test(
//       'test foods provider',
//       () async {
//         expect(mockFoods.foods, []);
//         arrangeFoods();
//         await mockFoods.fetchAndSetFoods('1', '2');
//         verify(() => mockFoods.fetchAndSetFoods('1', '2')).called(1);
//         expect(mockFoods.foods, foodsFromService);
//       },
//     );
//   });
// }
