import 'package:application/screens/dashboard/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:application/screens/tranction_history/trancation_history_screen.dart';

class FinanceDashboard extends StatelessWidget {
  const FinanceDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
//       DashboardHomeContent(),//
      const TransactionsScreen(),
      const Center(
        child: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ];

    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,

        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, index) {
            return IndexedStack(
              index: index,
              children: pages,
            );
          },
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(40),
            ),
            child: BlocBuilder<NavigationCubit, int>(
              builder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavIcon(
                      context,
                      icon: Icons.pie_chart,
                      active: index == 0,
                      onTap: () =>
                          context.read<NavigationCubit>().changeTab(0),
                    ),
                    _buildNavIcon(
                      context,
                      icon: Icons.sync_alt,
                      active: index == 1,
                      onTap: () =>
                          context.read<NavigationCubit>().changeTab(1),
                    ),
                    _buildNavIcon(
                      context,
                      icon: Icons.person_outline,
                      active: index == 2,
                      onTap: () =>
                          context.read<NavigationCubit>().changeTab(2),
                    ),
                  ],
                );
              },
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildNavIcon(
    BuildContext context, {
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 22,
        backgroundColor:
            active ? const Color(0xFF3F51B5) : Colors.transparent,
        child: Icon(
          icon,
          color: active ? Colors.white : Colors.white54,
        ),
      ),
    );
  }
}