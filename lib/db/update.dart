/// Firestore 업데이트는 하루에 한 번씩, 7일 전 데이터를 기준으로
/// ex) 9/30에 9/23 데이터 추가

import 'package:child_movie/db/movie_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:child_movie/db/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 최근 업데이트 년/월/일을 가져옴
Future<DateTime> getLastUpdatedDate() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int? year = prefs.getInt('updatedYear');
  int? month = prefs.getInt('updatedMonth');
  int? day = prefs.getInt('updatedDay');

  return DateTime(year!, month!, day!);
}

/// 업데이트 후 년/월/일을 저장
Future<void> setLastUpdatedDate(int year, int month, int day) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('updatedYear', year);
  await prefs.setInt('updatedMonth', month);
  await prefs.setInt('updatedDay', day);

  return;
}

/// Firebase의 가장 최근 업데이트 날짜를 계산
/// 당일 기준 7일 전 데이터가 가장 최신 데이터이지만, 23시에 업데이트하므로 편의상 8일전 데이터를 최신 데이터로 간주함
DateTime getUpdateDate() {
  DateTime now = DateTime.now();
  DateTime updateDate = DateTime(now.year, now.month, now.day - 8);
  return updateDate;
}

/// Firestore에서 영화 데이터들을 가져옴
///
/// DateTime 값을 인자로 받고, 년+월+일(ex 20230930)에 해당하는 컬렉션에서 영화정보들을 가져옴
Future<List<Movie>> getMovieFromFirestore(
    FirebaseFirestore firestore, DateTime date) async {
  List<Movie> movies = [];

  final moviesRef = firestore
      .collection('${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}')
      .withConverter<Movie>(
        fromFirestore: (snapshot, _) => Movie.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(), //do not use
      );

  await moviesRef.get().then((snapshot) {
    for (var doc in (snapshot.docs)) {
      movies.add(doc.data());
    }
  });
  return movies;
}

/// 영화정보들을 내부 db에 저장
Future<int> updateMovieInfo() async {
  List<Future<List<Movie>>> futures = [];
  int movieCount = 0;
  DateTime lastUpdatedDate = await getLastUpdatedDate(); // year, month, day

  DateTime updateDate = getUpdateDate();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // now.compareTo(future); // -1
  // now.compareTo(past); // 1
  // now.compareTo(now); // 0

  while (true) {
    lastUpdatedDate = DateTime(lastUpdatedDate.year, lastUpdatedDate.month, lastUpdatedDate.day + 1);
    if (updateDate.compareTo(lastUpdatedDate) < 0) {
      break;
    }
    futures.add(getMovieFromFirestore(firestore, lastUpdatedDate));
  }

  List<List<Movie>> movieList = await Future.wait(futures);

  MovieDatabase db = MovieDatabase();
  await db.openDB();

  for (List<Movie> movies in movieList) {
    movieCount += movies.length;
    for (Movie movie in movies) {
      db.insertMovie(movie);
    }
  }

  await setLastUpdatedDate(updateDate.year, updateDate.month, updateDate.day);

  return movieCount;
}
