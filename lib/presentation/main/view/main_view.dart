import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/constant.dart';
import '../../../app/dependency_injection.dart';
import '../../../domain/model/models.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/value_manager.dart';
import '../view_model/main_view_bloc.dart';
import '../view_model/main_view_event.dart';
import '../view_model/main_view_state.dart';
import 'movie_detail.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final MainViewBloc bloc;
  late int page;
  @override
  void initState() {
    page = 1;
    instance.resetLazySingleton<MainViewBloc>();
    bloc = instance<MainViewBloc>();
    bloc.add(FetchHomeDataEvent(page));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _BottomBar(),
      body: BlocBuilder<MainViewBloc, MainViewState>(
        bloc: bloc,
        builder: (context, state) {
          return state.getScreenWidget(
            context,
            _ContentWidget(),
            () => bloc.add(const FetchHomeDataEvent(1)),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}

class _BottomBar extends StatelessWidget {
  final bloc = instance<MainViewBloc>();

  @override
  Widget build(BuildContext context) {
    int currentPage = 1;
    if (bloc.state is MainViewContentState) {
      currentPage = bloc.mainViewObject?.page ?? 1;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        arrowIcon(() {
          bloc.add(ChangePageEvent(currentPage + 1));
        }, const Icon(Icons.arrow_back_ios)),
        Text("Page ${bloc.mainViewObject?.page??1}"),
        arrowIcon(() {
          if (currentPage > 1) {
            bloc.add(ChangePageEvent(currentPage - 1));
          }
        }, const Icon(Icons.arrow_forward_ios)),
      ],
    );
  }

  arrowIcon(VoidCallback onPressed, Icon icon) {
    return IconButton(onPressed: onPressed, icon: icon);
  }
}

class _ContentWidget extends StatelessWidget {
  final bloc = instance<MainViewBloc>();

  @override
  Widget build(BuildContext context) {
    final movies = bloc.mainViewObject?.movies ?? [];
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
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

  _navigateToDetail(BuildContext context, Results movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetail(movie),
      ),
    );
  }
}
