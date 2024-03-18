import 'package:flutter/material.dart';
import 'package:todolist/src/task/task_cards/task_card.dart';
import 'package:todolist/src/task/task_model.dart';
import 'package:todolist/src/task/tasklist_controller.dart';
import 'package:todolist/utils/alert.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});
  final pendingListUrl = '/tasks/list/?completed=False';
  final completedListUrl = '/tasks/list/?completed=True';
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
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(
                          text: "Pending Tasks",
                        ),
                        Tab(
                          text: "Completed Tasks",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        TaskListView(url: pendingListUrl),
                        TaskListView(url: completedListUrl),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskListView extends StatefulWidget {
  final String url;
  const TaskListView({super.key, required this.url});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  Future<Map<String, dynamic>>? _data;
  late String? _next = '';
  final listScrollController = ScrollController();
  final controller = TaskListController();
  @override
  void initState() {
    super.initState();
    _data = controller.loadList(url: widget.url);
    listScrollController.addListener(() {
      if (listScrollController.position.pixels ==
              listScrollController.position.maxScrollExtent &&
          _next != null) {
        debugPrint(_next);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _data = controller.loadMoreData(_data, _next);
          });
        });
      }
    });
  }

  Future refreshData() async {
    final data = controller.loadList(url: widget.url);
    setState(() {
      _data = Future.value(data);
    });
  }

  Future deleteData(Task task, BuildContext context) async {
    // function to delete task
    try {
      var data = await controller.deleteTask(task, _data);
      setState(() {
        _data = Future.value(data);
      });
    } on Exception {
      if (context.mounted) {
        Alert().show(context, "Deletion Failed !", "Please try again later");
      }
    }
  }

  @override
  void dispose() {
    listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
        future: _data,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.hasData) {
            debugPrint("futureBuilder Called");
            List<dynamic> newData = snapshot.data?['results'];
            _next = snapshot.data?['next'];
            if (newData.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: refreshData,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: listScrollController,
                  itemCount: newData.length,
                  itemBuilder: (BuildContext context, int index) {
                    Task task = Task.fromJSON(newData[index]);
                    return TaskCard(
                      task: task,
                      deleteTaskFn: deleteData,
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list,
                        size: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text("List Empty"),
                      )
                    ],
                  ),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.signal_wifi_connected_no_internet_4,
                      size: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text("Failed fetching data from server"),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
