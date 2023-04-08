import 'package:flutter/material.dart';

import '../../../common/page/base_scaffold.dart';
import '../../../common/page/base_text_style.dart';
import '../../../common/utils/color.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key, required this.body, required this.searchTap})
      : super(key: key);
  final Widget body;
  final Function(String searchStr) searchTap;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      actions: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(44, 6, 0, 6),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              border: Border.all(width: 1, color: AppColors.white),
            ),
            child: _searchBarWidget(),
          ),
        ),
        InkWell(
          onTap: () {
            widget.searchTap(_searchController.text);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            alignment: Alignment.center,
            child: BaseTextWidget(
              "搜索",
              style: baseTextStyle(color: AppColors.white),
            ),
          ),
        ),
      ],
      body: widget.body,
    );
  }

  Widget _searchBarWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Image.asset(
              "images/search_icon.png",
              width: 20,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 32,
              child: TextField(
                autofocus: true,
                controller: _searchController,
                keyboardType: TextInputType.text,
                style: baseTextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 13),
                  fillColor: AppColors.white,
                  hintText: "请输入搜索关键词",
                  border: InputBorder.none,
                  hintStyle: baseTextStyle(
                    color: AppColors.primarySubTitleColor212,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
