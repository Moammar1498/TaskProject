import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PastAppointmentsItem extends StatelessWidget {
  const PastAppointmentsItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      const NetworkImage('https://i.pravatar.cc/300'),
                  onBackgroundImageError: (exception, stackTrace) {
                    return;
                  },
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dr. Graham George',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Ink(
                        height: 28,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            )),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(children: [
                            Icon(
                              Icons.heart_broken,
                              color: Colors.red,
                              size: 18,
                            ),
                            Text('4.0')
                          ]),
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.video_call,
                            size: 18,
                          ),
                          Text('Video Session'),
                        ],
                      ),
                      const Text('Mathew Adam (me)'),
                    ]),
              ),
              const Gap(20),
              const Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '60 \$',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Gap(20),
                    Text(
                      'Monday, Oct 10, 08:30 PM',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
