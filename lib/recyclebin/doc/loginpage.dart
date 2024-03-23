import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MindMapScreen extends StatefulWidget {
  @override
  _MindMapScreenState createState() => _MindMapScreenState();
}

class _MindMapScreenState extends State<MindMapScreen> {
  List<MindMapNode> _nodes = [];

  void _addNode() {
    setState(() {
      _nodes.add(MindMapNode(
        title: 'New Node',
        date: DateTime.now(),
      ));
    });
  }

  void _addBranch(MindMapNode parent) {
    setState(() {
      parent.children.add(MindMapNode(
        title: 'New Branch',
        date: DateTime.now(),
      ));
    });
  }

  void _editNode(MindMapNode node) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditNodeScreen(node: node)),
    );
    if (result != null) {
      setState(() {
        node.title = result;
      });
    }
  }

  Widget _buildNode(MindMapNode node) {
    return GestureDetector(
      onTap: () => _editNode(node),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.blue[100],
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              node.title,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 8.0),
            Text(
              DateFormat.yMd().add_jm().format(node.date),
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranch(MindMapNode branch) {
    return GestureDetector(
      onTap: () => _editNode(branch),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.green[100],
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              branch.title,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 8.0),
            Text(
              DateFormat.yMd().add_jm().format(branch.date),
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMindMap(MindMapNode node) {
    if (node.children.isEmpty) {
      return _buildNode(node);
    }

    return Column(
      children: [
        _buildNode(node),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...node.children.map((branch) => _buildBranch(branch)).toList(),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _addBranch(node),
                  child: Text('Add Branch'),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...node.children.map((branch) => _buildMindMap(branch)).toList(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Mind Map'),
    ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ..._nodes.map((node) => _buildMindMap(node)).toList(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addNode,
                child: Text('Add Node'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditNodeScreen extends StatefulWidget {
  final MindMapNode node;

  EditNodeScreen({required this.node});

  @override
  _EditNodeScreenState createState() => _EditNodeScreenState();
}

class _EditNodeScreenState extends State<EditNodeScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.node.title;
  }

  void _save() {
    Navigator.pop(context, _textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Node'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _save,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          controller: _textEditingController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter node title',
          ),
        ),
      ),
    );
  }
}

class MindMapNode {
  String title;
  DateTime date;
  List<MindMapNode> children;

  MindMapNode({
    required this.title,
    required this.date,
    this.children = const [],
  });
}
