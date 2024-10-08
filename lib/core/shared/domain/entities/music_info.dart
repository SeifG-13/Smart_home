class MusicInfo {
  MusicInfo({required this.isOn, required this.currentSong});

  final bool isOn;
  final Song currentSong;
}

class Song {
  const Song(this.title, this.artist, this.thumbUrl);

  final String title;
  final String artist;
  final String thumbUrl;

  static const Song defaultSong = Song(
    'kazawi',
    'tatig13',
    'https://i.ibb.co/bQ65QkD/manesking.jpg',
  );
}
