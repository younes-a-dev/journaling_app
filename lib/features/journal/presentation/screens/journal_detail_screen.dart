import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trading_journal/core/utils/constants/app_size.dart';
import 'package:trading_journal/features/journal/domin/entity/journal.dart';
import 'package:trading_journal/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:trading_journal/features/journal/presentation/screens/full_screen_image.dart';
import 'package:trading_journal/features/journal/presentation/screens/journal_add_up_screen.dart';

class JournalDetailScreen extends StatefulWidget {
  JournalDetailScreen({this.journal, super.key});

  static const routeName = '/ journal Detail Screen';
  Journal? journal;

  @override
  State<JournalDetailScreen> createState() => _JournalDetailScreenState();
}

class _JournalDetailScreenState extends State<JournalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        appBar: AppBar(
          backgroundColor: const Color(0xff000000),
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xffbdbdbd)),
          actions: [
            if (widget.journal != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<JournalBloc>(context)
                        .add(DeleteJournalEvent(widget.journal!));
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.delete_outlined,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JournalAddUpScreen(
                              journal: widget.journal,
                            )),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        widget.journal = value;
                      });
                    }
                  });
                },
                icon: const Icon(Icons.edit_outlined),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.journal != null)
                  Container(
                    width: double.infinity,
                    height: size.height * .25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(FullScreenImage.routeName, arguments: {
                            'image': widget.journal!.imageByte!,
                            'title': widget.journal!.title
                          });
                        },
                        child: Hero(
                          tag: 'imageHero',
                          child: Image.memory(
                            widget.journal!.imageByte!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.journal != null)
                        Row(
                          children: [
                            if (widget.journal != null)
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color(widget.journal!.colorValue!)),
                              ),
                            gapW12,
                            Text(
                              '${widget.journal!.title}',
                              style: const TextStyle(
                                color: Color(0xffbdbdbd),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              // DateFormat.yMMMMEEEEd('en_US').format(widget.journal!.dateTime!),
                              DateFormat('EEEE MMM d, y HH:mm')
                                  .format(widget.journal!.selectedDateTime!),
                              style: const TextStyle(
                                  color: Color(0xff616161), fontSize: 16),
                            ),
                          ],
                        ),
                      gapH16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Direction :',
                                style: TextStyle(
                                  color: Color(0xff616161),
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Status :',
                                style: TextStyle(
                                  color: Color(0xff616161),
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Risk :',
                                style: TextStyle(
                                  color: Color(0xff616161),
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'R/R :',
                                style: TextStyle(
                                  color: Color(0xff616161),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          if (widget.journal != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.journal!.direction!,
                                  style: TextStyle(
                                    color: widget.journal!.direction == 'Long'
                                        ? Colors.green.withOpacity(.6)
                                        : Colors.red.withOpacity(.6),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  widget.journal!.status!,
                                  style: TextStyle(
                                    color: widget.journal!.status == 'Win'
                                        ? Colors.green.withOpacity(.6)
                                        : Colors.red.withOpacity(.6),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${widget.journal!.risk}',
                                  style: const TextStyle(
                                    color: Color(0xff616161),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${widget.journal!.riskReward}',
                                  style: const TextStyle(
                                    color: Color(0xff616161),
                                    fontSize: 16,
                                  ),
                                ),
                                // Text(
                                //   '${widget.journal!.xTrade}',
                                //   style: const TextStyle(
                                //     color: Color(0xff616161),
                                //     fontSize: 35,
                                //   ),
                                // ),
                              ],
                            ),
                        ],
                      ),
                      gapH8,
                      const Divider(
                        color: Color(0xff616161),
                        thickness: .5,
                      ),
                      gapH8,
                      const Text(
                        'Description :',
                        style: TextStyle(
                            color: Color(0xffbdbdbd),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      gapH8,
                      if (widget.journal != null)
                        Text(
                          '${widget.journal!.description}',
                          style: const TextStyle(
                              color: Color(0xff616161), fontSize: 14),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
