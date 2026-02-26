import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/category_entity.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_state.dart';
import '../bloc/category_event.dart';
import 'package:application/common/constant.dart';
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _categoryController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(LoadCategoriesEvent());
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "CATEGORIES",
          style: TextStyle(color: AppPalette.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SpacingConst.medium),
          child: Container(
            padding: const EdgeInsets.all(SpacingConst.medium),
            decoration: _cardDecoration(),
            child: Column(
              children: [

                /// 🔹 ADD CATEGORY ROW
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _categoryController,
                          style: const TextStyle(
                            color: AppPalette.white,
                            fontSize: AppFontSize.lg,
                          ),
                          decoration: InputDecoration(
                            hintText: "New category Name",
                            hintStyle: const TextStyle(
                              color: AppPalette.grey,
                              fontSize: AppFontSize.lg,
                            ),
                            filled: true,
                            fillColor:
                                AppPalette.grey.withOpacity(0.15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  SpacingConst.small),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(
                              horizontal: SpacingConst.medium,
                              vertical: SpacingConst.small,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: SpacingConst.small),

                    /// 🔹 ADD BUTTON
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppPalette.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                SpacingConst.small),
                          ),
                        ),
                        onPressed: () {
                          final name =
                              _categoryController.text.trim();

                          if (name.isNotEmpty) {
                            context.read<CategoryBloc>().add(
                                  AddCategoryEvent(name),
                                );
                            _categoryController.clear();
                          }
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppPalette.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: SpacingConst.medium),
                const Divider(color: AppPalette.white),
                const SizedBox(height: SpacingConst.small),

                /// 🔹 CATEGORY LIST
                Expanded(
                  child: BlocBuilder<CategoryBloc,
                      CategoryState>(
                    builder: (context, state) {
                      if (state.status ==
                          CategoryStatus.loading) {
                        return const Center(
                          child:
                              CircularProgressIndicator(),
                        );
                      }

                      if (state.status ==
                          CategoryStatus.error) {
                        return Center(
                          child: Text(
                            state.errorMessage ??
                                "Something went wrong",
                            style: const TextStyle(
                                color: AppPalette.error),
                          ),
                        );
                      }

                      if (state.categories.isEmpty) {
                        return const Center(
                          child: Text(
                            "No categories added",
                            style: TextStyle(
                                color: AppPalette.grey),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount:
                            state.categories.length,
                        itemBuilder: (context, index) {
                          final CategoryEntity
                              category =
                              state.categories[index];

                          return _categoryTile(
                            category.name,
                            onDelete: () {
                              context
                                  .read<CategoryBloc>()
                                  .add(
                                    DeleteCategoryEvent(
                                        category.id),
                                  );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppPalette.grey.withOpacity(0.1),
      borderRadius:
          BorderRadius.circular(SpacingConst.medium),
      border: Border.all(
        color: AppPalette.white.withOpacity(0.05),
      ),
    );
  }

  Widget _categoryTile(
    String title, {
    required VoidCallback onDelete,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: SpacingConst.small),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingConst.medium,
          vertical: SpacingConst.small,
        ),
        decoration: BoxDecoration(
          color: AppPalette.grey.withOpacity(0.15),
          borderRadius:
              BorderRadius.circular(SpacingConst.small),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppPalette.white,
                fontSize: AppFontSize.lg,
              ),
            ),
            GestureDetector(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(
                    SpacingConst.extraSmall),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      SpacingConst.small),
                  border: Border.all(
                    color:
                        AppPalette.error.withOpacity(0.6),
                  ),
                ),
                child: const Icon(
                  Icons.delete,
                  color: AppPalette.error,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}