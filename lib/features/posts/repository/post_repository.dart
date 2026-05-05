import 'package:dio/dio.dart';
import '../../../core/network/api_end_points.dart';
import '../model/post_model.dart';

class PostRepository {
  final Dio dio;

  PostRepository(this.dio);

  Future<List<PostModel>> fetchPosts(int page) async {
    try {
      final response = await dio.get(
        ApiEndpoints.posts,
        queryParameters: {
          "_page": page,
          "_limit": 10,
        },
      );

      return (response.data as List)
          .map((e) => PostModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception("Failed to load posts");
    }
  }

  Future<void> createPost(String title, String body) async {
    try {
      await dio.post(
        ApiEndpoints.posts,
        data: {
          "title": title,
          "body": body,
        },
      );
    } catch (e) {
      throw Exception("Failed to create post");
    }
  }
}