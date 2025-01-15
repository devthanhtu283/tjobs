import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectSeekerPage extends StatelessWidget {
  final List<String> recruiters = [
    'John Doe',
    'Jane Smith',
    'Michael Brown',
    'Emily Davis',
    'William Johnson'
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Chat with Recruiters'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.search),
          onPressed: () {
            // Handle search action
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                placeholder: 'Search recruiters...',
                onChanged: (value) {
                  // Handle search text changes
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recruiters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: CupertinoListTile(
                      leading: CircleAvatar(
                        child: Text(recruiters[index][0]),
                      ),
                      title: Text(recruiters[index], style: TextStyle(fontSize: 20),),
                      subtitle: Text('Last message from recruiter...', style: TextStyle(fontSize: 15),),
                      trailing: Text('12:34 PM'),
                      onTap: () {
                        // Handle tap on recruiter
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
