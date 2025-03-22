import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watch/presentation/main/view/widgets/bottom_bar.dart';
import 'package:watch/presentation/main/view/widgets/movies_list.dart';

import '../../../app/dependency_injection.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../view_model/main_view_bloc.dart';
import '../view_model/main_view_event.dart';
import '../view_model/main_view_state.dart';

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
    super.initState();
    page = 1;

    bloc = instance<MainViewBloc>();
    bloc.add(FetchHomeDataEvent(page));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const BottomBar(),
        body: BlocConsumer<MainViewBloc, MainViewState>(
          listener: (context, state) {
            if (state is MainViewContentState) {
              setState(() {});
            }
          },
          builder: (context, state) {
            return state.getScreenWidget(context, const _ContentWidget(), () {
              context.read<MainViewBloc>().add(const FetchHomeDataEvent(1));
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainViewBloc, MainViewState>(
      builder: (context, state) {
        final bloc = context.read<MainViewBloc>();

        if (bloc.mainViewObject?.movies == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final movies = bloc.mainViewObject!.movies;
        if (movies.isEmpty) {
          return const Center(child: Text("No Movies Found"));
        }

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieListItem(movie: movie);
          },
        );
      },
    );
  }
}
