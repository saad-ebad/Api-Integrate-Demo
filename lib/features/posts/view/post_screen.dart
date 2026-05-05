import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/post_view_model.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ref.read(postViewModelProvider.notifier).fetchPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: state.when(
        data: (posts) => ListView.builder(
          controller: scrollController,
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];

            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(postViewModelProvider.notifier)
              .createPost("New Title", "New Body");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}