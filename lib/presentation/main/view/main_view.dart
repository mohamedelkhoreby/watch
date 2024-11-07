import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/constant.dart';
import '../../../app/dependency_injection.dart';
import '../../../domain/model/models.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/value_manager.dart';
import '../view_model/main_viewmodel.dart';
import 'movie_detail.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => instance<MainViewModel>()..start(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<MainViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.state.getScreenWidget(
              context,
              _ContentWidget(),
              () => viewModel.start(),
            );
          },
        ),
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movies = context.watch<MainViewModel>().mainViewObject?.movies ?? [];

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final Results movie = movies[index];
        return _MovieListItem(movie: movie);
      },
    );
  }
}

class _MovieListItem extends StatelessWidget {
  final Results movie;

  const _MovieListItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToDetail(context, movie),
      child: Card(
        margin: const EdgeInsets.all(AppValue.v8),
        child: Padding(
          padding: const EdgeInsets.all(AppValue.v8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "${Constants.imageUrl}${movie.posterPath}",
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: AppValue.v10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: AppValue.v18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppValue.v8),
                    Text(
                      movie.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: AppValue.v14),
                    ),
                    const SizedBox(height: AppValue.v8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: AppValue.v20,
                        ),
                        const SizedBox(width: AppValue.v5),
                        Text(
                          movie.voteAverage.toString(),
                          style: const TextStyle(fontSize: AppValue.v14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Results movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetail(movie),
      ),
    );
  }
}
