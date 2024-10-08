import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/pharmacies/presentation/pages/pharmacies_list_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../core/presentation/widgets/back_button.dart';
import '../../../../core/presentation/widgets/not_auth_widget.dart';
import '../cubits/pharmacies_cubit/pharmacies_cubit.dart';
import 'archive_pharmacies_page.dart';

class MainPharmaciesPage extends StatefulWidget {
  const MainPharmaciesPage({super.key});

  @override
  State<MainPharmaciesPage> createState() => _MainPharmaciesPageState();
}

class _MainPharmaciesPageState extends State<MainPharmaciesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.isAuth
        ? Scaffold(
            appBar: AppBar(
              title: Text('my_pharmacies.myPharmacies'.tr()),
              leading: CustomBackButton(
                  color: context.isDark ? AppColors.white : AppColors.black),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: "my_pharmacies.title".tr()),
                      Tab(text: "my_pharmacies.archive_list".tr()),
                    ],
                    dividerColor: Colors.transparent,

                  ),
                ),
                Expanded(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => PharmaciesCubit(),
                      ),
                      BlocProvider(
                        create: (context) => PharmaciesCubit(),
                      ),
                    ],
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        PharmaciesListPage(),
                        ArchivePharmaciesPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: NotAuthWidget(
                content: Text('my_pharmacies.pharmacies_list'.tr())));
  }
}
