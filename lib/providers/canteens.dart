import '../models/canteen.dart';

class Canteens {
  static List<Canteen> _canteens = [
    Canteen(
      id: '0',
      name: 'Techno Edge',
      address: '2 Engineering Drive 4',
      url: 'assets/image/techno_edge.jpeg',
      location: [1.2980049391121178, 103.77174872516714],
    ),
    Canteen(
      id: '1',
      name: 'Frontier',
      address: '12 Science Drive 2',
      url: 'assets/image/frontier.jpeg',
      location: [1.2964300989550726, 103.78037128289583],
    ),
    Canteen(
      id: '2',
      name: 'The Deck',
      address: 'Computing Dr',
      url: 'assets/image/the_deck.png',
      location: [1.294423529654684, 103.77256924963808],
    ),
    Canteen(
      id: '3',
      name: 'Central Square',
      address: '31 Lower Kent Ridge Rd',
      url: 'assets/image/central_square.jpeg',
      location: [1.298502276155516, 103.77491627631773],
    ),
    Canteen(
      id: '4',
      name: 'Flavours',
      address: '2 College Ave West, Level 2 Stephen Riady Centre',
      url: 'assets/image/flavours.jpeg',
      location: [1.304720801683, 103.77272417991333],
    ),
    Canteen(
      id: '5',
      name: 'Fine Food',
      address: '1 Create Way, Town Plaza',
      url: 'assets/image/fine_food.jpeg',
      location: [1.3039283559392005, 103.77358279473005],
    ),
  ];

  static List<Canteen> get canteens {
    return [..._canteens];
  }
}
