import 'package:flutter/foundation.dart';
import 'package:todo_list/models/category_model.dart';
import 'package:todo_list/repositories/repository.dart';

class CategoryService {
  late Repository repository;

  CategoryService() {
    repository = Repository();
  }

  //create Data
  saveCategory(CategoryModel categoryModel) async {
    return await repository.insertData(
      'categories',
      categoryModel.categoryMap(),
    );
  }

  //read Data
  readCategory() async {
    return await repository.readData('categories');
  }

  //read Data By Id
  readCategoryById(categoryId) async {
    return await repository.readDataById(
      'categories',
      categoryId,
    );
  }

  //Update Data
  updateCategory(CategoryModel categoryModel) async {
    return await repository.updateData(
      'categories',
      categoryModel.categoryMap(),
    );
  }

  //Delete Data
  deleteCategory(categoryId) async {
    return repository.deleteData(
      'categories',
      categoryId,
    );
  }
}
