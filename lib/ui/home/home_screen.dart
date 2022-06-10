import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviezflutter/ui/components/no_internet_connection.dart';
import 'package:moviezflutter/ui/home/discover/discover_page.dart';
import 'package:moviezflutter/ui/home/discover/discover_page_controller.dart';
import 'package:moviezflutter/ui/home/home/home_page.dart';
import 'package:moviezflutter/ui/home/home/home_page_controller.dart';
import 'package:moviezflutter/ui/home/home_screen_controller.dart';
import 'package:moviezflutter/ui/home/saved/saved_page.dart';
import 'package:moviezflutter/ui/home/saved/saved_page_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  HomeScreenController get controller => HomeScreenController.it;

  @override
  Widget build(BuildContext context) {
    final pages = [const HomePage(), const DiscoverPage(), const SavedPage()];

    return Obx(() {
      return Scaffold(
        bottomNavigationBar: _bottomNavigationBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<SavedPageController>().getMovies(refresh: true);
            Get.find<DiscoverPageController>().getMovies(refresh: true);
            Get.find<HomePageController>().getMovies(refresh: true);
          },
          child: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              children: [
                Positioned.fill(child: pages[controller.selectedPage.value]),
                if (controller.connection.value !=
                    NetworkConnectionState.connected)
                  const NoInternetConnection(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: controller.selectedPage.value,
        onTap: controller.changePage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: "Discover"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), label: "Saved"),
        ]);
  }
}
