import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/main_view_bloc.dart';
import '../../view_model/main_view_event.dart';
import '../../view_model/main_view_state.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainViewBloc, MainViewState>(
      builder: (context, state) {
        final bloc = context.read<MainViewBloc>();
        int currentPage = bloc.mainViewObject?.page ?? 1;
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              arrowIcon(() {
                if (currentPage > 1) {
                  bloc.add(ChangePageEvent(currentPage - 1));
                }
              }, Icons.arrow_back_ios, currentPage > 1),
              Text("Page $currentPage",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              arrowIcon(() {
                bloc.add(ChangePageEvent(currentPage + 1));
              }, Icons.arrow_forward_ios, true),
            ],
          ),
        );
      },
    );
  }

  Widget arrowIcon(VoidCallback onPressed, IconData icon, bool isEnabled) {
    return IconButton(
      onPressed: isEnabled ? onPressed : null,
      icon: Icon(icon, color: isEnabled ? Colors.black : Colors.grey),
    );
  }
}
