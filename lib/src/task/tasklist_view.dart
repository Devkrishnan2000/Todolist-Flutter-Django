import 'package:flutter/material.dart';
import 'package:todolist/src/task/pending_list/pending_task_card.dart';
import 'package:todolist/src/task/task_model.dart';
import 'package:todolist/src/task/tasklist_controller.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

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
            const Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
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
                        TaskListView(),
                        Text("Completed task"),
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
  const TaskListView({super.key});

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
    _data = controller.loadList();
    listScrollController.addListener(() {
      if (listScrollController.position.pixels ==
              listScrollController.position.maxScrollExtent &&
          _next != null) {
        debugPrint(_next);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _data = loadMoreData();
          });
        });
      }
    });
  }

  Future<Map<String, dynamic>> loadMoreData() async {
    Map<String, dynamic>? data = await _data;
    List<dynamic> prevResults = data?['results'];
    Map<String, dynamic>? newData = await controller.loadList(url: _next);
    List<dynamic> newResults = newData['results'];
    prevResults.addAll(newResults);
    newData['results'] = prevResults;
    return newData;
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
            List<dynamic> newData = snapshot.data?['results'];
            _next = snapshot.data?['next'];
            if(newData.isNotEmpty)
              {
                return ListView.builder(
                  controller: listScrollController,
                  itemCount: newData.length,
                  itemBuilder: (BuildContext context, int index) {
                    Task task = Task.fromJSON(newData[index]);
                    return TaskCard(task: task);
                  },
                );
              }
            else
              {
                return const Center(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.list,size: 40,),
                        Padding(
                          padding: EdgeInsets.only(top:8.0),
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
                    Icon(Icons.signal_wifi_connected_no_internet_4,size: 40,),
                    Padding(
                      padding: EdgeInsets.only(top:8.0),
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
