import 'package:flutter/material.dart';
import 'package:todolist/src/task/list/complete_list/complete_list_view.dart';
import 'package:todolist/src/task/list/pending_list/pending_list_view.dart';

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
                        PendingListView(),
                        CompleteListView(),
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
