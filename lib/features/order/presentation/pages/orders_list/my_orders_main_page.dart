import 'package:dawaa24/core/presentation/widgets/not_auth_widget.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/order/presentation/cubits/my_live_orders_cubit/my_live_orders_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/my_historic_orders_cubit/my_historic_orders_cubit.dart';
import 'my_historic_orders_page.dart';
import 'my_latest_orders_page.dart';

class MyOrdersMainPage extends StatefulWidget {
  const MyOrdersMainPage({super.key});

  @override
  State<MyOrdersMainPage> createState() => _MyOrdersMainPageState();
}

class _MyOrdersMainPageState extends State<MyOrdersMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return context.isAuth
        ? Scaffold(
            appBar: AppBar(
              title: Text('my_orders.title'.tr()),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: context.theme.primaryColor,
                    tabs: [
                      Tab(text: "my_orders.upcoming".tr()),
                      Tab(text: "my_orders.history".tr()),
                    ],
                    overlayColor: MaterialStateProperty.all(
                  context.theme.primaryColor.withAlpha(50)),
                  ),
                ),
                Expanded(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            MyLatestOrdersCubit()..getLatestList(),
                      ),
                      BlocProvider(
                        create: (context) =>
                            MyHistoricOrdersCubit()..getHistoricList(),
                      ),
                    ],
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        MyLiveOrdersPage(),
                        MyHistoricOrdersPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(child: NotAuthWidget(content: Text('my_orders.title'.tr())));
  }
}
