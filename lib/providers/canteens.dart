import '../models/canteen.dart';

class Canteens {
  static List<Canteen> _canteens = [
    Canteen(
        id: '0',
        name: 'Techno Edge',
        address: '2 Engineering Drive 4',
        url: 'assets/image/techno_edge.jpeg'),
    Canteen(
        id: '1',
        name: 'Frontier',
        address: '12 Science Drive 2',
        url: 'assets/image/frontier.jpeg'),
    Canteen(
        id: '2',
        name: 'The Deck',
        address: 'Computing Dr',
        url: 'assets/image/the_deck.png'),
    Canteen(
        id: '3',
        name: 'Central Square',
        address: '31 Lower Kent Ridge Rd',
        url: 'assets/image/central_square.jpeg'),
    Canteen(
        id: '4',
        name: 'Flavours',
        address: '2 College Ave West, Level 2 Stephen Riady Centre',
        url: 'assets/image/flavours.jpeg'),
    Canteen(
        id: '5',
        name: 'Fine Food',
        address: '1 Create Way, Town Plaza',
        url: 'assets/image/fine_food.jpeg'),
  ];

  static List<Canteen> get canteens {
    return [..._canteens];
  }
}
