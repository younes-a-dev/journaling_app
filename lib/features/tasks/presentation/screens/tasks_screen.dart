import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_journal/core/widgets/custom_text_field.dart';
import 'package:trading_journal/features/tasks/domin/entity/task.dart';
import 'package:trading_journal/features/tasks/presentation/bloc/get_tasks_status.dart';
import 'package:trading_journal/features/tasks/presentation/bloc/task_bloc.dart';

import '../../../../core/utils/constants/app_size.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:toastification/toastification.dart';

import 'notifications_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TextEditingController _taskController = TextEditingController();
  // set reminder button title
  String btnTitle = 'Set reminder';
  bool isReminderSet = false;
  DateTime? userSelectedDateTime;
  int? secends;

  late int id;
  // generate random number for use as task and alarm id
  void generateUniqueID() {
    const int max32Bit = 2147483647;
    id = Random().nextInt(max32Bit);
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

// when reminder set for task, set reminder button title chage to selected date and time
  void setReminderTitle(DateTime date) {
    String datex = DateFormat('y/M/d').format(date);
    String time = DateFormat('HH:mm').format(date);
    btnTitle = '$datex  $time';
    // setState(() {
    //   btnTitle = date.toString().trim();
    // });
  }

  // Calculate secends for set reminder
  void getSecends(DateTime date) {
    DateTime userSelectedDate = date;
    Duration difrrence = userSelectedDate.difference(DateTime.now());
    int diffrenceInSecends = difrrence.inSeconds;
    secends = diffrenceInSecends;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskBloc>(context).add(GetTasksEvent());
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        appBar: AppBar(
          backgroundColor: const Color(0xff000000),
          title: const Text(
            'Tasks',
            style: TextStyle(
              color: Color(0xffbdbdbd),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(NotificationsScreen.routeName);
              },
              child: const Icon(
                FluentIcons.alert_48_regular,
                color: Color(0xffbdbdbd),
              ),
            ),
            gapW24,
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xffbdbdbd),
                        ),
                        gapW12,
                        Text(
                          'Delete all  tasks',
                          style: TextStyle(color: Color(0xffbdbdbd)),
                        ),
                      ],
                    ),
                  ),
                ],
                color: const Color(0xff212121),
                elevation: 2,
                child: const Icon(
                  FluentIcons.more_vertical_48_regular,
                  color: Color(0xffbdbdbd),
                ),
                onSelected: (value) {
                  if (value == "delete") {
                    _showDialog(context).then((_) {
                      setState(() {});
                    });
                  }
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH16,
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  // Loading
                  if (state.getTasksStatus is GetTasksLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // Completed
                  if (state.getTasksStatus is GetTasksCompleted) {
                    final GetTasksCompleted getTasksCompleted =
                        state.getTasksStatus as GetTasksCompleted;
                    final List<Task> tasks = getTasksCompleted.tasks;

                    if (tasks.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: tasks.length,
                          itemBuilder: (ctx, i) => Dismissible(
                            key: ValueKey(tasks[i].dateTime.toString()),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            const Color(0xff212121),
                                        title: const Text('Delete',
                                            style: TextStyle(
                                                color: Color(0xffbdbdbd))),
                                        content: const Text(
                                          'Are you sure you want to delete this task?',
                                          style:
                                              TextStyle(color: Colors.white38),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              child: const Text('No',
                                                  style: TextStyle(
                                                      color: Colors.white30))),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                              child: const Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                        ],
                                      );
                                    });
                              }
                              return null;
                            },
                            background: Container(),
                            secondaryBackground: const Padding(
                              padding: EdgeInsets.only(right: 20, bottom: 30),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                            onDismissed: (direction) {
                              BlocProvider.of<TaskBloc>(context)
                                  .add(DeleteTaskEvent(tasks[i]));
                              BlocProvider.of<TaskBloc>(context)
                                  .add(GetTasksEvent());
                            },
                            child: GestureDetector(
                              onTap: () {
                                _showAddTaskDialog(context, tasks[i].content,
                                    tasks[i].dateTime, tasks[i]);
                                // It checks that if the task does not have a reminder, it does not change the name of the button
                                if (tasks[i].alarmID != null) {
                                  setReminderTitle(tasks[i].dateTime);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: size.height * .08,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 16, 16, 16),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: tasks[i].isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          tasks[i].isChecked = value!;
                                        });
                                        BlocProvider.of<TaskBloc>(context)
                                            .add(UpdateTaskEvent(tasks[i]));
                                      },
                                      activeColor:
                                          const Color.fromARGB(255, 16, 16, 16),
                                      checkColor: const Color(0xffffca28),
                                    ),
                                    gapW24,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: size.width * .60,
                                          child: Text(
                                            tasks[i].content,
                                            style: const TextStyle(
                                                color: Color(0xffbdbdbd)),
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        if (tasks[i].timeOfRemider != null)
                                          Row(
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                  tasks[i].timeOfRemider!,
                                                  style: const TextStyle(
                                                      color: Colors.white30),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              gapW8,
                                              tasks[i]
                                                      .dateTime
                                                      .difference(
                                                          DateTime.now())
                                                      .inSeconds
                                                      .isNegative
                                                  ? const Text('Expired',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffffca28)))
                                                  : const Icon(Icons.alarm,
                                                      color: Color(0xffffca28),
                                                      size: 15)
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: size.height / 3),
                      child: const Center(
                        child: Column(
                          children: [
                            Icon(FluentIcons.clipboard_task_24_regular,
                                color: Colors.white38, size: 28),
                            gapH16,
                            Text(
                              'No tasks here yet',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Error
                  if (state.getTasksStatus is GetTasksError) {
                    return const Center(
                      child: Text('Error'),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 20),
          child: FloatingActionButton(
            backgroundColor: const Color(0xffffca28),
            elevation: 0,
            foregroundColor: const Color(0xff212121),
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            onPressed: () => _showAddTaskDialog(context, null, null, null),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  //confirm delete tasks dialog
  Future<void> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff212121),
          title: const Text(
            "Delete",
            style: TextStyle(color: Color(0xffbdbdbd), fontSize: 18),
          ),
          content: const Text(
            "Are you sure you want to delete all tasks?",
            style: TextStyle(
              color: Color(0xffbdbdbd),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                    const Text('No', style: TextStyle(color: Colors.white30))),
            TextButton(
                onPressed: () {
                  BlocProvider.of<TaskBloc>(context).add(DeleteAllTasksEvent());
                  Navigator.of(context).pop();
                },
                child: const Text('Yes', style: TextStyle(color: Colors.red))),
          ],
        );
      },
    );
  }

  // Add task dialog
  void _showAddTaskDialog(BuildContext context, String? content,
      DateTime? dateTime, Task? editedTask) {
    TextEditingController _contentController =
        TextEditingController(text: content);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        return StatefulBuilder(
          builder: (context, newSetState) {
            return AlertDialog(
              backgroundColor: const Color(0xff212121),
              // actionsOverflowButtonSpacing: 100,
              actionsAlignment: MainAxisAlignment.spaceBetween,
              content: SizedBox(
                // height: 350,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width / 2,
                      child: CustomTextFieldWidget(
                          controller: content == null
                              ? _taskController
                              : _contentController,
                          textInputType: TextInputType.multiline,
                          maxLine: 5,
                          autoFocus: true,
                          prefixIcon: Icons.check_box_outline_blank_rounded,
                          hintText: '...'),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        picker.DatePicker.showDateTimePicker(
                          context,
                          showTitleActions: true,
                          theme: const picker.DatePickerTheme(
                            titleHeight: 60,
                            itemHeight: 45,
                            headerColor: Color(0xff212121),
                            backgroundColor: Color(0xff212121),
                            cancelStyle: TextStyle(
                              color: Color(0xffbdbdbd),
                              fontSize: 16,
                            ),
                            itemStyle: TextStyle(
                                color: Color(0xffbdbdbd),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle: TextStyle(
                              color: Color(0xffffca28),
                              fontSize: 16,
                            ),
                          ),
                          minTime: DateTime.now(),
                          maxTime: DateTime(2030, 12, 29, 23, 59),
                          currentTime: dateTime ?? DateTime.now(),
                          // onChanged: (date) {},
                          onConfirm: (date) {
                            getSecends(date);
                            setReminderTitle(date);
                            userSelectedDateTime = date;
                            isReminderSet = true;
                          },
                          onCancel: () {
                            btnTitle = 'Set reminder';
                            isReminderSet = false;
                          },
                          locale: picker.LocaleType.en,
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.alarm_add_rounded,
                              color: Color(0xffffca28),
                              size: 18,
                            ),
                            gapW4,
                            Text(
                              btnTitle,
                              style: const TextStyle(color: Colors.white38),
                            ),
                          ],
                        ),
                      ),
                    ),
                    gapW8,
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: InkWell(
                        splashColor: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          newSetState(() {
                            isReminderSet = false;
                            btnTitle = 'Set reminder';
                          });
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.white38,
                          size: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Color(0xffffca28)),
                      ),
                      onPressed: () {
                        if (_taskController.text.isEmpty &&
                            _contentController.text.isEmpty) {
                          toastification.show(
                            context: context,
                            type: ToastificationType.error,
                            style: ToastificationStyle.fillColored,
                            autoCloseDuration: const Duration(seconds: 5),
                            title: const Text('Error',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            description: const Text('Content cant be empty',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                            alignment: Alignment.topCenter,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            icon: const Icon(Icons.priority_high_rounded),
                            showIcon: true, // show or hide the icon
                            primaryColor: Colors.red,
                            backgroundColor: const Color(0xff212121),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            borderRadius: BorderRadius.circular(12),
                            showProgressBar: true,
                            closeButtonShowType: CloseButtonShowType.onHover,
                            closeOnClick: true,
                            pauseOnHover: true,
                            dragToClose: true,
                          );
                        } else {
                          if (content != null) {
                            BlocProvider.of<TaskBloc>(context)
                                .add(DeleteTaskEvent(editedTask!));
                          }
                          generateUniqueID();
                          if (isReminderSet == true) {
                            Task task = Task(
                              id: id,
                              content: content == null
                                  ? _taskController.text
                                  : _contentController.text,
                              secendsToRemind: secends,
                              alarmID: id,
                              dateTime: userSelectedDateTime!,
                              timeOfRemider: btnTitle,
                              createdDate: DateTime.now(),
                            );

                            BlocProvider.of<TaskBloc>(context)
                                .add(AddTaskEvent(task));
                            isReminderSet = false;
                            btnTitle = 'Set reminder';
                          } else {
                            Task task = Task(
                              id: id,
                              content: content == null
                                  ? _taskController.text
                                  : _contentController.text,
                              dateTime: DateTime.now(),
                              createdDate: DateTime.now(),
                            );

                            BlocProvider.of<TaskBloc>(context)
                                .add(AddTaskEvent(task));
                          }
                          setState(() {});
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      btnTitle = 'Set reminder';
      _taskController.text = '';
    });
  }
}
