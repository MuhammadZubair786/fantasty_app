

import 'package:fantasyapp/models/flix_response.dart';
import 'package:fantasyapp/utils/flix_constants.dart';
import 'package:nb_utils/nb_utils.dart';

List<HomeSlider> getSliders() {
  List<HomeSlider> list = [];
  list.add(HomeSlider(slideImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJFoeEEH9Gy6VxFN2fbqc9A_8l9dJsYy5g8Q&s", isHD: false));

  list.add(HomeSlider(slideImage: "https://i.ibb.co/XJ9j3Fx/DALL-E-2024-12-18-12-51-54-A-vibrant-and-dynamic-illustration-of-a-fictional-NJPW-New-Japan-Pro-Wres.png", isHD: false));
  list.add(HomeSlider(slideImage: "https://i.ibb.co/FwhP64G/DALL-E-2024-12-18-12-51-21-A-vibrant-and-dynamic-illustration-of-a-fictional-AEW-wrestling-league-fe.png", isHD: false));


  list.add(HomeSlider(slideImage: "https://www.mykhel.com/common_dynamic/images/common/pro-wrestling-league.1627678834.jpg", isHD: true));

  list.add(HomeSlider(slideImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ24SQmkBeKaFEieAFZaVwzRCJj7qqcx1sRfw&s", isHD: true));
  return list;
}

List<Movie> getMovie() {
  List<Movie> list = [];
  list.add(Movie(slideImage: "images/muvi/items/poster_ek27.jpg", isHD: true));
  list.add(Movie(slideImage: "images/muvi/items/poster_ek29.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/poster_ek31.jpg", isHD: true));
  list.add(Movie(slideImage: "images/muvi/items/poster_ek33.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/poster_ek35.jpg", isHD: true));
  list.add(Movie(slideImage: "images/muvi/items/poster_ek27.jpg", isHD: false));

  return list;
}

List<Movie> getTrendingOnMovie() {
  List<Movie> list = [];
  list.add(Movie(slideImage: "images/muvi/items/poster_ek27.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/poster_ek29.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/poster_ek31.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/poster_ek33.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/poster_ek35.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/poster_ek27.jpg", isHD: false));

  return list;
}

List<Movie> getMadeForYouMovie() {
  List<Movie> list = [];
  list.add(Movie(slideImage: "images/muvi/items/poster_ek27.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/Images6.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/Images9.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/Images10.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/Images14.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/Images10.jpg", isHD: false));

  return list;
}

List<Movie> getHorizontalMovie() {
  List<Movie> list = [];
  list.add(Movie(slideImage: "images/muvi/items/rectangle_ek9.jpg", isHD: true));
  list.add(Movie(slideImage: "images/muvi/items/rectangle_ek11.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/rectangle_ek13.jpg", isHD: true));
  list.add(Movie(slideImage: "images/muvi/items/rectangle_ek24.jpg", isHD: false));
  list.add(Movie(slideImage: "images/muvi/items/rectangle_ek26.jpg", isHD: false));

  return list;
}

 final List<Map<String, String>> featuredLeagues = [
    {"name": "National Wrestling Alliance (NWA)", "image": "https://i.ytimg.com/vi/l9wbNMEzsu0/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLA9GJqJEh1eBu-pwTjrKJ3ox1DH-A", "details": "Ongoing matches."},
    {"name": "Bloodline Wrestling Alliance (BWA)", "image": "https://i.ytimg.com/vi/o_gkz2kKWGM/maxresdefault.jpg", "details": "Top-tier teams competing."},
    {"name": "National Wrestling Circuit (NWC)", "image": "https://www.dawrestlingsite.com/media/images/feature_nwc1.jpg", "details": "Battle of champions."},
    {"name": "Total Mayhem Wrestling (TMW)", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNfiFlAfjscWW6Uvjj9A8y72jRkx1XhrbXLQPVlSoFjks0FQ0eAFUxBs_EBIIUa1RY2_U&usqp=CAU", "details": "Battle of champions."},
  
  ];

  final List<Map<String, String>> topTeams = [
    {"name": "Team A", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2hlJQlq5udd7LK2rcSoo5yYZ7XozChVnSGw&s"},
    {"name": "Team B", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTENdjDCOqMnGzZGnJI44CmmIWdNxTr6nKS_w&s"},
    {"name": "Team C", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHxQf2KBjb9u1LlGt_e5ZscT9ypiWn8GV02g&s"},
    {"name": "Team D", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhGwbba17gYD1I7RbO_eoC4tU031KhtKEzaw&s"},
  ];

  final List<Map<String, String>> allLeagues = [
    {"name": "World Wrestling Entertainment's", "description": "Exciting matchups happening now."},
    {"name": "AEW League", "description": "Top teams battling it out."},
    {"name": "New Japan Pro-Wrestling's", "description": "Underdogs making a statement."},
    {"name": "World Wrestling Entertainment's", "description": "Underdogs making a statement."},
    {"name": "All Elite Wrestling's", "description": "Underdogs making a statement."},
   
  ];
  
List<Movie> getContinueMovies() {
  List<Movie> list = [];
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek1.jpg", isHD: true, percent: 0.2, title: "Joker"));
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek7.jpg", isHD: false, percent: 0.8, title: "The Scorch Trials"));
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek1.jpg", isHD: true, percent: 0.4, title: "Fantastic Four"));
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek11.jpg", isHD: false, percent: 0.5, title: "Itaewon Class"));
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek17.jpg", isHD: false, percent: 0.1, title: "The Cars"));
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek21.jpg", isHD: false, percent: 0.9, title: "Coco"));

  return list;
}

List<Movie> getMyListMovies() {
  List<Movie> list = [];
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek11.jpg", isHD: false, percent: 0.5, title: "Itaewon Class"));
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek17.jpg", isHD: true, percent: 0.4, title: "Conjuring 3"));
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek21.jpg", isHD: false, percent: 0.9, title: "Coco"));
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek11.jpg", isHD: false, percent: 0.1, title: "The Cars"));

  return list;
}

List<Movie> getDownloadedMovies() {
  List<Movie> list = [];
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek23.jpg", isHD: false, percent: 0.5, title: "Frozen 2"));
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek25.jpg", isHD: true, percent: 0.4, title: "Ip Man 4"));
  list.add(Movie(slideImage: "images/muvi/items/thumbnail_ek27.jpg", isHD: false, percent: 0.9, title: "Man of Steel"));

  return list;
}

List<FAQ> getFaq() {
  List<FAQ> list = [];
  list.add(FAQ(
      title: "How to delete conitnue watching",
      subTitle:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. ",
      isExpanded: false));
  list.add(FAQ(
      title: "How to delete conitnue watching",
      subTitle:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. ",
      isExpanded: false));
  list.add(FAQ(
      title: "How to delete conitnue watching",
      subTitle:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. ",
      isExpanded: false));
  list.add(FAQ(
      title: "How to delete conitnue watching",
      subTitle:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. ",
      isExpanded: false));
  list.add(FAQ(
      title: "How to delete conitnue watching",
      subTitle:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. ",
      isExpanded: false));

  return list;
}

List<Movie> getActors() {
  List<Movie> list = [];
  list.add(Movie(slideImage: "$BaseUrl/images/muvi/items/t3_ic_profile1.png", isHD: true, percent: 0.2, title: "Rajiv Kapoor"));
  list.add(Movie(slideImage: "$BaseUrl/images/muvi/items/t3_ic_profile2.png", isHD: false, percent: 0.8, title: "John doe"));
  list.add(Movie(slideImage: "$BaseUrl/images/muvi/items/t3_ic_profile3.png", isHD: true, percent: 0.4, title: "Alice Denial"));
  list.add(Movie(slideImage: "$BaseUrl/images/muvi/items/t3_ic_profile5.png", isHD: false, percent: 0.5, title: "John Vinaas"));
  list.add(Movie(slideImage: "$BaseUrl/images/muvi/items/t3_ic_profile6.png", isHD: false, percent: 0.1, title: "Alexender Cinah"));
  list.add(Movie(slideImage: "$BaseUrl/images/muvi/items/t3_ic_profile7.png", isHD: false, percent: 0.9, title: "Tim Svages"));

  return list;
}

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'images/flag/ic_us.png'),
    LanguageDataModel(id: 2, name: 'Hindi', languageCode: 'hi', fullLanguageCode: 'hi-IN', flag: 'images/flag/ic_hi.png'),
    LanguageDataModel(id: 3, name: 'Arabic', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: 'images/flag/ic_ar.png'),
    LanguageDataModel(id: 4, name: 'French', languageCode: 'fr', fullLanguageCode: 'fr-FR', flag: 'images/flag/ic_fr.png'),
  ];
}

