import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final Map userDetails;
  UserDetails({@required this.userDetails});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              userDetails['name'],
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Year of Birth: ',
                  style: TextStyle(),
                ),
                Text(
                  userDetails['birth_year'],
                  style: TextStyle(
                    color: Colors.indigo,
                  ),
                )
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Photo ID: ',
                  style: TextStyle(),
                ),
                Text(
                  userDetails['photo_id_type'],
                  style: TextStyle(
                    color: Colors.indigo,
                  ),
                )
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'ID Number: ',
                  style: TextStyle(),
                ),
                Text(
                  userDetails['photo_id_number'],
                  style: TextStyle(
                    color: Colors.indigo,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
