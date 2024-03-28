import 'package:flutter/material.dart';
import 'package:todolist/src/settings/settings_view.dart';
import 'package:todolist/src/task/home_page_controller.dart';
import 'package:todolist/src/task/list/tasklist_view.dart';
import 'package:todolist/utils/appbar.dart';
import 'package:todolist/utils/permission_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final homePageController = HomePageController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    GetPermission.getNotificationPermission();
    _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    _tabController.addListener(_handleTabIndex);
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.show(),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          text: "Pending",
                        ),
                        Tab(
                          text: "Completed",
                        ),
                        Tab(
                          text: "Settings",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        const TaskListView(
                          listUrl: '/tasks/list/?completed=False',
                          tag: "pending",
                        ),
                        const TaskListView(
                          listUrl: '/tasks/list/?completed=True',
                          tag: "completed",
                        ),
                        SettingsView(),
                      ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton:
            homePageController.floatingButton(_tabController.index));
  }
}
