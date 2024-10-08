import 'package:dawaa24/core/presentation/widgets/loading_banner.dart';
import 'package:dawaa24/core/services/notification_handler.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/main/presentation/cubits/main_page_cubit/main_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/blocs/theme_bloc/theme_bloc.dart';
import '../../../../di/injection.dart';
import '../../../chat/presentation/pages/pharamcy_chat_list.dart';
import '../../../notification/presentation/pages/notification_list_page.dart';
import '../cubits/main_page_cubit/main_page_cubit.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/my_drawer.dart';
import '../widgets/nav_bar.dart';
import 'new_home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final homeNavKey = GlobalKey<NavigatorState>();
  final searchNavKey = GlobalKey<NavigatorState>();
  final notificationNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  late PageController pageController;
  late List<Widget> pages;
  final themeBloc = getIt<ThemeBloc>();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    if (context.isAuth) {
      getIt<NotificationHandler>().handleMessageOnBackground(context);
      BlocProvider.of<MainPageCubit>(context).getUserInfo();
    }

    pages = [
      const KeepAlivePage(child: NewHomePage()),
      const KeepAlivePage(child: PharmacyChatListPage()),
      const KeepAlivePage(child: NotificationListPage()),
    ];
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainPageCubit, MainPageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: selectedTab != 0
              ? null
              : homeAppBar(
                  context: context,
                  themeBloc: themeBloc,
                ),
          drawer: MyDrawer(
            onLanguageChanged: () {
              BlocProvider.of<MainPageCubit>(context).refreshPage();
              setState(() {});
            },
            onProfileUpdated: () {
              BlocProvider.of<MainPageCubit>(context).getUserInfo();
              setState(() {});
            },
          ),
          body: state.status == MainPageStatus.loading
              ? const LoadingBanner()
              : PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  children: pages,
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: state.status == MainPageStatus.loading
              ? null
              : NavBar(
                  pageIndex: selectedTab,
                  onTap: (index) {
                    if (index == selectedTab) {
                      pageController.jumpToPage(index);
                    } else {
                      pageController.jumpToPage(index);
                    }
                    setState(() {
                      selectedTab = index;
                    });
                  },
                ),
        );
      },
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  final Widget child;

  const KeepAlivePage({super.key, required this.child});

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
