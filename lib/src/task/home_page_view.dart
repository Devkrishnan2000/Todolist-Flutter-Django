import 'package:flutter/material.dart';
import 'package:todolist/src/task/home_page_controller.dart';
import 'package:todolist/src/task/list/tasklist_view.dart';

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
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _tabController.addListener(_handleTabIndex);
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: 130,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/splash.png"),
                        fit: BoxFit.fill)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Center(
                          child: Text(
                        "Todo List",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 42,
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          text: "Pending Tasks",
                        ),
                        Tab(
                          text: "Completed Tasks",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                          controller: _tabController,
                          children: const [
                            TaskListView(
                              listUrl: '/tasks/list/?completed=False',
                              tag: "pending",
                            ),
                            TaskListView(
                              listUrl: '/tasks/list/?completed=True',
                              tag: "completed",
                            ),
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
