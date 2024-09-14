import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_journal/core/utils/constants/app_size.dart';
import 'package:trading_journal/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:trading_journal/features/journal/presentation/widgets/toggle_switch_widget.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/popup_menu_button_widget.dart';
import '../../domin/entity/journal.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:toastification/toastification.dart';

class JournalAddUpScreen extends StatefulWidget {
  const JournalAddUpScreen({this.journal, super.key});

  final Journal? journal;

  static const routeName = '/ Add-Update journal screen';

  @override
  State<JournalAddUpScreen> createState() => _JournalAddUpScreenState();
}

class _JournalAddUpScreenState extends State<JournalAddUpScreen> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController riskRewardController = TextEditingController();
  late TextEditingController riskController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDateTime;
  // used for picked date button title
  String? _selectedDate;
  File? _image;
  Uint8List? imageUint8List;
  int colorValue = 0xffE4FF1A;
  int statusValue = 0;
  int directionValue = 0;

  void setDirection(int index) {
    directionValue = index;
  }

  void setStatus(int index) {
    statusValue = index;
  }

  void setColor(int color) {
    colorValue = color;
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }

    // Convert image file to bytes
    List<int> imageBytes = await pickedFile!.readAsBytes();
    imageUint8List = Uint8List.fromList(imageBytes);
  }

  @override
  void dispose() {
    titleController.dispose();
    riskRewardController.dispose();
    riskController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    colorValue = widget.journal?.colorValue ?? 0xffE4FF1A;
    titleController = TextEditingController(text: widget.journal?.title ?? '');
    riskRewardController = TextEditingController(
        text: widget.journal?.riskReward.toString() ?? '');
    riskController = TextEditingController(text: widget.journal?.risk ?? '');
    descriptionController =
        TextEditingController(text: widget.journal?.description ?? '');
    if (widget.journal != null) {
      _selectedDateTime = widget.journal!.selectedDateTime!;
      widget.journal!.direction == 'Long'
          ? directionValue = 0
          : directionValue = 1;
      widget.journal!.status == 'Win' ? statusValue = 0 : statusValue = 1;
      imageUint8List = widget.journal!.imageByte!;
    }
    super.initState();
  }

  // Method to show the DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(2000), // Start date for picker
      lastDate: DateTime(2101), // End date for picker
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xffbdbdbd), // Header background color
            colorScheme: const ColorScheme.light(
              // primary: Color(0xffffca28),
              onSurface: Color(0xffbdbdbd),
              // background: Color(0xff212121), // Selected date background color
              // onBackground: Color(0xff212121),
              // primaryContainer: Color(0xff212121),
              // onSecondary:  Color(0xff212121),
              surface: Color(0xff212121),
              // background: Colors.red,
              // inversePrimary: Colors.red,
              // inverseSurface: Colors.red,
              onBackground: Color(0xffffca28),
              // onInverseSurface: Colors.red,
              onPrimary: Color(0xffffca28),
              // onPrimaryContainer: Colors.red,
              // onPrimaryFixed: Colors.red,
              // onPrimaryFixedVariant: Colors.red,
              // onSecondary: Colors.red,
              // onSecondaryContainer: Colors.red,
              // onSecondaryFixed: Colors.red,
              // onSecondaryFixedVariant: Colors.red,
              onSurfaceVariant: Color(0xffbdbdbd),
              // onTertiary: Colors.red,
              // onTertiaryContainer: Colors.red,
              // onTertiaryFixed: Colors.red,
              // onTertiaryFixedVariant: Colors.red,
              // outline: Colors.red,
              // outlineVariant: Colors.green,
              primary: Colors.white54,
              // primaryContainer: Colors.red,
              // primaryFixed: Colors.red,
              // primaryFixedDim: Colors.red,
              // scrim: Colors.red,
              // secondary: Colors.red,
              // secondaryContainer: Colors.red,
              // secondaryFixed: Colors.red,
              // shadow: Colors.red,
              // surfaceBright: Colors.red,
              // tertiaryFixedDim: Colors.red,
              // surfaceContainer: Colors.red,
              // //  surfaceContainerHigh: Colors.red,
              // surfaceContainerHighest: Colors.red,
              // surfaceContainerLow: Colors.red,
              // surfaceContainerLowest: Colors.red,
              // surfaceDim: Colors.red,
              // surfaceTint: Colors.red,
              // surfaceVariant: Colors.red,
              // tertiary: Colors.red,
              // tertiaryFixed: Colors.red,
              // tertiaryContainer: Colors.red,
            ),
            // textButtonTheme: TextButtonThemeData(
            //   style: TextButton.styleFrom(
            //     primary: Colors.deepPurple, // Button text color
            //   ),
            // ),
            // dialogBackgroundColor: Colors.white, // Background color of the dialog
            // // Customizing the text styles
            // textTheme: TextTheme(
            //   bodyText1: TextStyle(color: Colors.purple), // Body text color
            //   bodyText2: TextStyle(color: Colors.purple), // Body text color
            // ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      // If the date is picked, show the TimePicker
      _selectTime(context, pickedDate);
    }
  }

  // Method to show the TimePicker
  Future<void> _selectTime(BuildContext context, DateTime date) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xffbdbdbd), // Header background color
            colorScheme: const ColorScheme.light(
              onSurface: Color(0xffbdbdbd),
              primaryContainer: Colors.transparent,
              onSecondary: Color(0xffffca28),
              surface: Color(0xff212121),
              onBackground: Color(0xffffca28),
              onPrimary: Color(0xffffca28),
              onPrimaryContainer: Color(0xffffca28),
              primary: Colors.white54,
              onSurfaceVariant: Colors.white38,
              onTertiary: Color(0xffffca28),
              onTertiaryContainer: Color(0xffffca28),
              outline: Colors.white38,
              secondary: Colors.transparent,
              surfaceContainerHigh: Color(0xff212121),
              tertiary: Colors.transparent,
            ),
            textTheme: const TextTheme(),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      // If the time is picked, set the combined DateTime
      setState(() {
        _selectedDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        String datex = DateFormat('y/M/d').format(date);
        // String time = DateFormat('HH:mm').format();
        _selectedDate =
            '${DateFormat('EEE').format(date)}\n$datex\n${pickedTime.hour}:${pickedTime.minute}';
      });
    }
  }

  String setPickDataBtnTitle() {
    String title = 'Pick date';
    if (widget.journal == null) {
      title = _selectedDate ?? "Pick date";
    } else {
      title = _selectedDate ??
          DateFormat('EEE\nMMM d, y\n HH:mm')
              .format(widget.journal!.selectedDateTime!);
    }
// widget.journal == null ?  _selectedDate ?? "Pick date" :  DateFormat('EEE\nMMM d, y\n HH:mm').format(widget.journal!.dateTime!),

    return title;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            // widget.
            widget.journal == null ? 'ADD JOURNAL' : 'EDIT JOURNAL',
            style: const TextStyle(
                color: Color(0xffbdbdbd), fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xff000000),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                onPressed: () {
                  if (imageUint8List == null) {
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
                      description: const Text('Please choose an image. ',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      alignment: Alignment.bottomCenter,
                      animationDuration: const Duration(milliseconds: 300),
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
                  } else if (_formKey.currentState!.validate()) {
                    Journal journal = Journal(
                      title: titleController.text,
                      description: descriptionController.text,
                      colorValue: colorValue,
                      selectedDateTime: _selectedDateTime ?? DateTime.now(),
                      imageByte: imageUint8List,
                      risk: riskController.text,
                      riskReward: riskRewardController.text.isEmpty
                          ? 0
                          : double.parse(riskRewardController.text),
                      direction: directionValue == 0 ? 'Long' : 'Short',
                      status: statusValue == 0 ? 'Win' : 'Loss',
                      date: DateTime.now(),
                    );
                    if (widget.journal == null) {
                      BlocProvider.of<JournalBloc>(context)
                          .add(AddJournalEvent(journal));
                      Navigator.of(context).pop();
                    } else {
                      BlocProvider.of<JournalBloc>(context)
                          .add(DeleteJournalEvent(widget.journal!));
                      BlocProvider.of<JournalBloc>(context)
                          .add(AddJournalEvent(journal));
                      Navigator.of(context).pop(journal);
                    }
                  }
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Color(0xffffca28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Color(0xffbdbdbd)),
        ),
        backgroundColor: const Color(0xff000000),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * .7,
                        height: 40,
                        child: CustomTextFormFieldWidget(
                          textInputType: TextInputType.text,
                          controller: titleController,
                          hintText: 'Title',
                          maxLine: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title cant be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 50,
                        height: 40,
                        child: PopUpMenuColorButtonWidget(
                          menuList: [
                            ...MenuItem.colors.map(
                                (item) => PopupMenuItem<PopupMenuItemModel>(
                                      // padding:
                                      //     const EdgeInsets.only(left: 2, right: 2),
                                      child: item.widget,
                                      onTap: () {
                                        setState(() {
                                          setColor(item.colorValue!);
                                        });
                                      },
                                    ))
                          ],
                          colorValue: colorValue,
                          // title: _timeTitle,
                          // widthSize: size.width * .005,
                        ),
                      ),
                    ],
                  ),
                  gapH16,
                  // image
                  Container(
                    width: size.width,
                    height: size.height * .2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.withOpacity(.2),
                      // border: Border.all(color: widget.journal==null ? const   Color(0xffbdbdbdb) : Colors.transparent,width: .5,),
                    ),
                    child:
                        // widget.
                        widget.journal == null
                            ? GestureDetector(
                                onTap: () {
                                  _getImage();
                                },
                                child: _image == null
                                    ? const Icon(
                                        FluentIcons.image_add_24_regular,
                                        color: Colors.white38,
                                        size: 28)
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.file(_image!,
                                            // width: size.width,
                                            // height: size.height * .2,
                                            fit: BoxFit.fill)),
                              )
                            : Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: _image == null
                                          ? Image.memory(
                                              widget.journal!.imageByte!,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(_image!,
                                              fit: BoxFit.cover)),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black87,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: IconButton(
                                        onPressed: () {
                                          _getImage();
                                        },
                                        icon: const Icon(
                                          Icons.mode_edit_outline_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gapH16,
                      ToggleSwitchWidget(
                        title: 'Direction',
                        initValue: directionValue,
                        labels: const ['LONG', 'SHORT'],
                        onToggleFunction: (int index) {
                          setDirection(index);
                        },
                      ),
                      gapH16,
                      ToggleSwitchWidget(
                        title: 'Status',
                        initValue: statusValue,
                        labels: const ['WIN', 'LOSS'],
                        onToggleFunction: (int index) {
                          setStatus(index);
                        },
                      ),
                      gapH16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * .28,
                            height: 40,
                            child: CustomTextFormFieldWidget(
                              textInputType: TextInputType.number,
                              controller: riskRewardController,
                              hintText: 'R/R',
                              maxLine: 1,
                            ),
                          ),
                          SizedBox(
                            width: size.width * .28,
                            height: 40,
                            child: CustomTextFormFieldWidget(
                              textInputType: TextInputType.text,
                              controller: riskController,
                              hintText: 'Risk',
                              maxLine: 1,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => _selectDate(context),
                            label: Text(
                              setPickDataBtnTitle(),
                              style: const TextStyle(color: Color(0xffbdbdbd)),
                              textAlign: TextAlign.center,
                            ),
                            icon: const Icon(
                              FluentIcons.calendar_ltr_48_regular,
                              color: Color(0xffbdbdbd),
                            ),
                          ),
                        ],
                      ),
                      // const Spacer(),
                      gapH12,
                      Container(
                        height: size.height * .3,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            color: const Color(0xff212121),
                            borderRadius: BorderRadius.circular(16)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                controller: descriptionController,
                                maxLines: 100,
                                keyboardType: TextInputType.multiline,
                                style:
                                    const TextStyle(color: Color(0xffbdbdbd)),
                                cursorColor: const Color(0xffbdbdbd),
                                // onChanged: (value) {
                                //   // _descriptionCracter(value);
                                // },
                                decoration: const InputDecoration(
                                  hintText: 'Description',
                                  hintStyle:
                                      TextStyle(color: Color(0xffbdbdbd)),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
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
}
