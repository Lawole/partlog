// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
//
// import '../../common/app_colors.dart';
// import '../../common/ui_helpers.dart';
// import 'home_viewmodel.dart';
//
// class HomeView extends StackedView<HomeViewModel> {
//   const HomeView({Key? key}) : super(key: key);
//
//   @override
//   Widget builder(
//     BuildContext context,
//     HomeViewModel viewModel,
//     Widget? child,
//   ) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 25.0),
//           child: Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 verticalSpaceLarge,
//                 Column(
//                   children: [
//                     const Text(
//                       'Hello, STACKED!',
//                       style: TextStyle(
//                         fontSize: 35,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                     verticalSpaceMedium,
//                     MaterialButton(
//                       color: Colors.black,
//                       onPressed: viewModel.incrementCounter,
//                       child: Text(
//                         viewModel.counterLabel,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MaterialButton(
//                       color: kcDarkGreyColor,
//                       onPressed: viewModel.showDialog,
//                       child: const Text(
//                         'Show Dialog',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     MaterialButton(
//                       color: kcDarkGreyColor,
//                       onPressed: viewModel.showBottomSheet,
//                       child: const Text(
//                         'Show Bottom Sheet',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   HomeViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//       HomeViewModel();
// }


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context,
      HomeViewModel viewModel,
      Widget? child,
      ) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF00BCD4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Animated Header
                FadeTransition(
                  opacity: viewModel.headerAnimation,
                  child: Text(
                    'Hello, ${viewModel.userName}!',
                    // style: GoogleFonts.poppins(
                    //   fontSize: 28,
                    //   fontWeight: FontWeight.bold,
                    //   color: Colors.white,
                    // ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeTransition(
                  opacity: viewModel.headerAnimation,
                  child: const Text(
                    'Welcome to Your Dashboard',
                    // style: GoogleFonts.poppins(
                    //   fontSize: 16,
                    //   color: Colors.white70,
                    // ),
                  ),
                ),
                const SizedBox(height: 24),
                // Dashboard Cards
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildDashboardCard(
                        title: 'Analytics',
                        icon: Icons.analytics,
                        color: Colors.white,
                        onTap: viewModel.navigateToAnalytics,
                        animation: viewModel.cardAnimation,
                      ),
                      _buildDashboardCard(
                        title: 'Tasks',
                        icon: Icons.task,
                        color: Colors.white,
                        onTap: viewModel.navigateToTasks,
                        animation: viewModel.cardAnimation,
                      ),
                      _buildDashboardCard(
                        title: 'Profile',
                        icon: Icons.person,
                        color: Colors.white,
                        onTap: viewModel.navigateToProfile,
                        animation: viewModel.cardAnimation,
                      ),
                      _buildDashboardCard(
                        title: 'Settings',
                        icon: Icons.settings,
                        color: Colors.white,
                        onTap: viewModel.navigateToSettings,
                        animation: viewModel.cardAnimation,
                      ),
                    ],
                  ),
                ),
                // Logout Button
                Center(
                  child: ScaleTransition(
                    scale: viewModel.buttonAnimation,
                    child: ElevatedButton.icon(
                      onPressed: viewModel.logout,
                      icon: const Icon(Icons.logout),
                      label: Text(
                        'Logout',
                        // style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required Animation<double> animation,
  }) {
    return ScaleTransition(
      scale: animation,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 48,
                  color: color,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  // style: GoogleFonts.poppins(
                  //   fontSize: 18,
                  //   fontWeight: FontWeight.w600,
                  //   color: color,
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.initAnimations(this as TickerProvider);
  }
}