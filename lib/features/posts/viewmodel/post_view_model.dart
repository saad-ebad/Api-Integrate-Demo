import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../model/post_model.dart';
import '../repository/post_repository.dart';
import '../../../core/network/dio_client.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  final dio = ref.read(dioProvider);
  return PostRepository(dio);
});

final postViewModelProvider =
StateNotifierProvider<PostViewModel, AsyncValue<List<PostModel>>>(
        (ref) {
      final repo = ref.read(postRepositoryProvider);
      return PostViewModel(repo);
    });

class PostViewModel extends StateNotifier<AsyncValue<List<PostModel>>> {
  final PostRepository repo;

  int _page = 1;
  bool _isLoading = false;
  List<PostModel> _posts = [];

  PostViewModel(this.repo) : super(const AsyncLoading()) {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    if (_isLoading) return;

    _isLoading = true;

    try {
      final newPosts = await repo.fetchPosts(_page);
      _posts.addAll(newPosts);
      _page++;

      state = AsyncData(_posts);
    } catch (e, st) {
      state = AsyncError(e, st);
    }

    _isLoading = false;
  }

  Future<void> createPost(String title, String body) async {
    try {
      await repo.createPost(title, body);
      fetchPosts();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}