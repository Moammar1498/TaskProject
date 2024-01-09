import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PastAppointmentsItem extends StatelessWidget {
  const PastAppointmentsItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Ink(
        height: 120,
        width: 350,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xffDDDDDD),
              blurRadius: 3.0,
              spreadRadius: 2.0,
              offset: Offset(1.0, 2.0),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    const NetworkImage('https://i.pravatar.cc/300'),
                onBackgroundImageError: (exception, stackTrace) {
                  return;
                },
              ),
              const Gap(8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(
                  children: [
                    Text(
                      'Dr. Graham George',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(64),
                    Text(
                      '60 \$',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Ink(
                      height: 24,
                      width: 50,
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          )),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Row(children: [
                          ImageIcon(
                            AssetImage('assets/images/like.png'),
                            color: Colors.red,
                            size: 18,
                          ),
                          Text(
                            '4.0',
                            style: TextStyle(fontSize: 11),
                          )
                        ]),
                      ),
                    ),
                    const Gap(8),
                    const Text(
                      'submitted',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
                const Gap(5),
                const Row(
                  children: [
                    Icon(
                      Icons.video_call,
                      size: 18,
                    ),
                    Text(
                      'Video Session',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                const Gap(5),
                const Row(
                  children: [
                    Text(
                      'Mathew Adam (me)',
                      style: TextStyle(fontSize: 10),
                    ),
                    Gap(30),
                    Text(
                      'Monday, Oct 10, 08:30 PM',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
