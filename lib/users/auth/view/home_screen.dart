import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmarket/users/auth/controllers/home_controller.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_productcard.dart';
import 'package:localmarket/widget/app_search.dart';
import 'package:localmarket/widget/app_tap.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshProducts,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    AppSearchBar(
                      controller: controller.searchController,
                      hint: 'Search products or shops',
                      onChanged: controller.onSearchChanged,
                      onFilterTap: () {},
                    ),
                    const SizedBox(height: 16),
                    Text(tr('customer.categories'),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Obx(() => AppCategoryTabs(
                          items: controller.categoryKeys
                              .map((k) => CategoryTabItem(
                                  key: k, label: tr('categories.$k')))
                              .toList(),
                          selectedKey: controller.selectedCategory.value,
                          onSelected: controller.selectCategory,
                        )),
                    const SizedBox(height: 20),
                    Text(tr('customer.featured_products'),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                  ]),
                ),
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (controller.errorMessage.value != null) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(controller.errorMessage.value!),
                      ),
                    ),
                  );
                }
                if (controller.userPos.value == null) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(tr('errors.location_permission_denied'),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: controller.refreshProducts,
                              child: Text(tr('common.retry')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                final list = controller.filteredProducts;
                if (list.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text(tr('common.no_data'))),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.58,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final p = list[i];
                        final d = controller.distanceKm(p);
                        return AppProductCard(
                          product: p,
                          distanceText:
                              d == null ? null : '${d.toStringAsFixed(1)} km',
                          onViewTap: () {},
                        );
                      },
                      childCount: list.length,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}