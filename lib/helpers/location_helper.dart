const GOOGLE_API_KEY = 'AIzaSyAqQi721ckz57KLYwGU46bHnrFPo4xAAtI';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=18&size=640x640&scale=2&maptype=roadmap&markers=color:red%7Clabel:%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
