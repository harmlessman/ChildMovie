import 'package:flutter/material.dart';
import 'package:child_movie/db/movie.dart';
import 'package:child_movie/pages/movie_info_page.dart';
import 'package:child_movie/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// 범죄도시
// 퍼시픽

List<Widget> makePreviewWidgets(List<Movie> movies, BuildContext context) {
  List<Widget> items = [];
  for (Movie movie in movies) {
    items.add(TextButton(
        onPressed: () {
          print(movie.useTitle);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieInfoPage(
                movie: movie,
              ),
            ),
          );
        },
        child: ListTile(
          leading: getRatingImage(movie.gradeName, width: 50.w, height: 50.h),
          title: Text(movie.useTitle!),
          subtitle: Text(movie.oriTitle!),
        )));
  }
  return items;
}
