import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/view_model/exercise/workout_tab_view_model.dart';

class AllConfettiWidget extends StatelessWidget {
  final Widget child;
  const AllConfettiWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController:
                Provider.of<WorkoutTabViewModel>(context, listen: true)
                    .confettiController,
            colors: const [
              Colors.red,
              Colors.green,
              Colors.blue,
              Colors.orange,
              Colors.yellow
            ],
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 50,
          ),
        ),
        child,
      ],
    );
  }
}
