import 'package:attendance/constant/app_style/app_color.dart';
import 'package:attendance/models/subject/subject_model.dart';
import 'package:attendance/view/home/tab_bar/student/student_tab.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'attendance/attendance_tab.dart';
import 'history/history_tab.dart';

class CustomTabBarPage extends StatefulWidget {
  final SubjectModel? model;
  const CustomTabBarPage({Key? key, required this.model}) : super(key: key);

  @override
  _CustomTabBarPageState createState() => _CustomTabBarPageState();
}

class _CustomTabBarPageState extends State<CustomTabBarPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22, top: 16),
                    child: Text(
                        "${widget.model!.subjectName} (${widget.model!.departmentName}-${widget.model!.batchName})",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20,
                            color: kTextWhiteColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.015,
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: kSecondaryColor,
                    controller: _tabController,
                    labelColor: kTextWhiteColor,
                    labelStyle: const TextStyle(
                        fontSize: 13,
                        color: kTextWhiteColor,
                        fontWeight: FontWeight.w700),
                    unselectedLabelColor: kTextWhiteColor.withOpacity(0.8),
                    tabs: const [
                      Tab(
                        child: Text('ATTENDANCE'),
                      ),
                      Tab(
                        child: Text('STUDENTS'),
                      ),
                      Tab(
                        child: Text('HISTORY'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AttendanceTab(subId: widget.model!.subjectId.toString()),
                  StudentTab(subId: widget.model!.subjectId.toString()),
                  HistoryTab(subId: widget.model!.subjectId.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
