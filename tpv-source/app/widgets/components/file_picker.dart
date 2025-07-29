import 'dart:io';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar archivo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Archivo seleccionado',
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _selectedFile == null
                      ? 'Ningún archivo seleccionado'
                      : _selectedFile!.path,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: _pickFile,
                icon: Icon(Icons.folder_open),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    /* final directory = await getApplicationDocumentsDirectory();
    final file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (file != null) {
      setState(() {
        _selectedFile = file;
      });
    }*/
  }
}
