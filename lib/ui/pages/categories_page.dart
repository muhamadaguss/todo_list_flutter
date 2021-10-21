import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/category_model.dart';
import 'package:todo_list/services/category_services.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController editcategoryController = TextEditingController();
  TextEditingController editdescriptionController = TextEditingController();
  final _category = CategoryModel();
  final _categoryService = CategoryService();

  List<CategoryModel> _categoryList = [];

  var category;

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = [];
    var categories = await _categoryService.readCategory();
    categories?.forEach((category) {
      setState(() {
        var categoryModel = CategoryModel();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      editcategoryController.text = category[0]['name'] ?? 'No Name';
      editdescriptionController.text =
          category[0]['description'] ?? 'No Description';
    });
    _editFormDialog(context);
  }

  _addFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (params) {
          return AlertDialog(
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.blue,
                onPressed: () async {
                  _category.name = categoryController.text;
                  _category.description = descriptionController.text;
                  await _categoryService.saveCategory(_category);
                  getAllCategories();
                  Navigator.maybePop(context);
                  _showSuccessSnackBar(
                    const Text('Success Add Data'),
                  );
                },
                child: const Text('Save'),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.grey,
                onPressed: () => Navigator.maybePop(context),
                child: const Text('Cancel'),
              ),
            ],
            title: const Text('Categories Form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                      hintText: 'Write a Category',
                      labelText: 'Categories',
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Write a Desccription',
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (params) {
          return AlertDialog(
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.blue,
                onPressed: () async {
                  _category.id = category[0]['id'];
                  _category.name = editcategoryController.text;
                  _category.description = editdescriptionController.text;
                  await _categoryService.updateCategory(_category);
                  getAllCategories();
                  Navigator.maybePop(context);
                  _showSuccessSnackBar(
                    const Text('Data Updated'),
                  );
                },
                child: const Text('Update'),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.grey,
                onPressed: () => Navigator.maybePop(context),
                child: const Text('Cancel'),
              ),
            ],
            title: const Text('Edit Categories Form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: editcategoryController,
                    decoration: const InputDecoration(
                      hintText: 'Write a Category',
                      labelText: 'Categories',
                    ),
                  ),
                  TextField(
                    controller: editdescriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Write a Desccription',
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (params) {
          return AlertDialog(
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.blue,
                onPressed: () async {
                  await _categoryService.deleteCategory(categoryId);
                  getAllCategories();
                  Navigator.maybePop(context);
                  _showSuccessSnackBar(
                    const Text('Data Deleted'),
                  );
                },
                child: const Text('Delete'),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.grey,
                onPressed: () => Navigator.maybePop(context),
                child: const Text('Cancel'),
              ),
            ],
            title: const Text(
              'Are you sure to delete this data ?',
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    // ignore: deprecated_member_use
    _globalKey.currentState!.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: const Text('Categories'),
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addFormDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: IconButton(
                  onPressed: () =>
                      editCategory(context, _categoryList[index].id),
                  icon: const Icon(Icons.edit),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_categoryList[index].name!),
                    IconButton(
                      onPressed: () => _deleteFormDialog(
                        context,
                        _categoryList[index].id,
                      ),
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ],
                ),
                subtitle: Text(_categoryList[index].description!),
              ),
            ),
          );
        },
      ),
    );
  }
}
