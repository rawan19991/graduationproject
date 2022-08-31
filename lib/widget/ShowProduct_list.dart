import 'package:flutter/material.dart';

Widget showCategory({String name, String des, String image,Function functionEdit,Function functionDelete,}) {
  return ListTileTheme(
    contentPadding: EdgeInsets.all(15),
    iconColor: Color.fromRGBO(255, 193, 47, 1.0),
    textColor: Colors.black54,
    tileColor: Colors.yellow[100],
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'CrimsonText'),
        ),
        subtitle: Text(
          des,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontFamily: 'SourceCodePro'),
        ),
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 60,
            minHeight: 60,
            maxWidth: 60,
            maxHeight: 60,
          ),
          child: Image.asset(image, fit: BoxFit.fill),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: functionEdit

            , icon: Icon(Icons.edit)),
            IconButton(onPressed:functionDelete, icon: Icon(Icons.delete)),
          ],
        ),
      ),
    ),
  );
}
