class FavoriteListModel {
  static List<String> itemNames = [
    'PLUMBAGO',
    'PENNISETUM SETACEUM',
    'DIANELLA TASMANICA ',
    'OPHIOPOGON ',
    'PANDANUS',
    'PITTOSPORUM TOBIRA',
    'ASPARAGUS DENSIFLORUS',
    'IPOMOEA',
    'ALTERNANTHERA',
    'IRESINE',
    'RHOEO SPATHACEA',
    'PORTULACA',
    'ASYSTASIA GANGETICA',
    'JASMINUM GRANDIFLORUM',
    'RUSSELIA EUISETIFORMIS',
    'WEDELIA TRILOBATA',
    'BARLERIA CRISTATA',
    'BUXUS MICROPHYLLA',
    'PHALARIS ARUNDINACEA',
    'TRADESCANTIA ZEBRINA',
    'ALOE VERA',
    'SHAMI',
    'ZZ PLANT',
    'CHRISTMAS CACTUS',
    'AGAVE',
    'KANER',
    'CROWN OF THORNS',
    'SNAKE PLANT',
    'DAYLILY',
    'DUMB CANE',
    'SHOWY STONECROP',

  ];
  static List<String> itemSubtitle =[
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors',
    'Outdoors/Indoor',
    'Outdoors',
    'Indoor',
    'Indoor',
    'Indoor',
    'Outdoors/Indoor',
    'Outdoors/Indoor',
    'Indoor',
    'Outdoors',
    'Indoor',
    'Outdoors',
  ];
  static List<String> itemImages =[
    ('assets/images/image1.jpg'),
    ('assets/images/image2.jpg'),
    ('assets/images/image3.jpg'),
    ('assets/images/image4.jpg'),
    ('assets/images/image5.jpg'),
    ('assets/images/image6.jpg'),
    ('assets/images/image7.jpg'),
    ('assets/images/image8.jpg'),
    ('assets/images/image9.jpg'),
    ('assets/images/image10.jpg'),
    ('assets/images/image11.jpg'),
    ('assets/images/image12.jpg'),
    ('assets/images/image13.jpg'),
    ('assets/images/image14.jpg'),
    ('assets/images/image15.jpg'),
    ('assets/images/image16.jpg'),
    ('assets/images/image17.jpg'),
    ('assets/images/image18.jpg'),
    ('assets/images/image19.jpg'),
    ('assets/images/image20.jpg'),
    ('assets/images/image21.jpg'),
    ('assets/images/image22.jpg'),
    ('assets/images/image23.jpg'),
    ('assets/images/image24.jpg'),
    ('assets/images/image25.jpg'),
    ('assets/images/image26.jpg'),
    ('assets/images/image27.jpg'),
    ('assets/images/image28.jpg'),
    ('assets/images/image29.jpg'),
    ('assets/images/image30.jpg'),
    ('assets/images/image31.jpg'),
  ];
  Item getById(int id) => Item(
    id, 
    itemNames[id % itemNames.length],
    itemSubtitle[id % itemSubtitle.length],
    itemImages[id % itemImages.length],
  );
  Item getByPosition(int position){
    return getById(position);
  }
}
class Item{
  final int id;
  final String Name;
  final String Subtitle;
  final String image;

  const Item(
      this.id,
      this.Name,
      this.Subtitle,
      this.image,
      );
  @override
  int get hashcode => id;

  @override
  bool operator == (Object other) => other is Item && other.id == id;

}