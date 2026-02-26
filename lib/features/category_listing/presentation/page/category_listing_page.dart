import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/category_entity.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_state.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("CATEGORIES"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {

            /// 🔥 Loading
            if (state.status == CategoryStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            /// 🔥 Error
            if (state.status == CategoryStatus.error) {
              return Center(
                child: Text(
                  state.errorMessage ?? "Something went wrong",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            /// 🔥 Loaded
            if (state.status == CategoryStatus.loaded) {

              if (state.categories.isEmpty) {
                return const Center(
                  child: Text(
                    "No categories found",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (context, index) {

                  final CategoryEntity category =
                      state.categories[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              );
            }

            /// 🔥 Initial
            return const SizedBox();
          },
        ),
      ),
    );
  }
}