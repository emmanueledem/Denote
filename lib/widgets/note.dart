import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../core/navigators/navigators.dart';

// ignore: must_be_immutable
class Note extends StatelessWidget {
  Note({
    Key? key,
    required this.noteTitle,
    required this.noteDescription,
    required this.dateAdded,
    required this.colorCode,
  }) : super(key: key);

  String noteTitle;
  String noteDescription;
  String dateAdded;
  Color colorCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colorCode,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton(
                icon: const Icon(Icons.more_horiz),
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit Note'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete Note'),
                    )
                  ];
                },
                onSelected: (String value) {
                },
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.viewNote);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noteTitle,
                  style: const TextStyle(
                      fontSize: 19.0,
                      fontFamily: 'VarelaRound',
                      fontWeight: FontWeight.bold),
                ),
                Text(dateAdded.toString()),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  noteDescription.length > 20
                      ? noteDescription.substring(0, 20) + '...'
                      : noteDescription,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'VarelaRound',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
