import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/search/presentation/search_page_controller.dart';
import 'package:fusion_app_store/app/search/presentation/search_page_states_and_events.dart';
import 'package:fusion_app_store/app/search/presentation/widgets/search_option.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    required this.controller,
    required this.state,
    required this.onSearch,
  });

  final SearchPageController controller;
  final SearchPageInitializedState state;
  final void Function(String query) onSearch;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  bool focussed = false;

  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchTextController.text = widget.state.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.bounceIn,
      width: 620,
      height: 60,
      decoration: BoxDecoration(
        color: Color(focussed ? 0xFFF0F0F5 : 0xFFF7F7F7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
            ),
            const Gap(10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(4),
                  Expanded(
                    child: Autocomplete<String>(
                      initialValue: searchTextController.value,
                      optionsBuilder: (textEditingValue) {
                        return buildSuggestions(
                          searchText: textEditingValue.text,
                        );
                      },
                      fieldViewBuilder: (context, textEditingController,
                          focusNode, onFieldSubmitted) {
                        return FocusableActionDetector(
                          onFocusChange: (value) {
                            focussed = value;
                            rebuild();
                          },
                          child: TextFormField(
                            controller: textEditingController,
                            style: AppTheme.fontSize(14).makeMedium(),
                            focusNode: focusNode,
                            onFieldSubmitted: (value) {
                              onFieldSubmitted();
                              widget.onSearch(value);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Search Apps ...",
                              hintStyle: AppTheme.fontSize(14)
                                  .makeMedium()
                                  .withColor(Colors.grey.shade800),
                            ),
                          ),
                        );
                      },
                      onSelected: (option) {
                        widget.onSearch(option);
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        return Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Container(
                            width: 500,
                            height: 300,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: options
                                    .map((e) => SearchOption(
                                        option: e, onSelected: onSelected))
                                    .toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> buildSuggestions({required String searchText}) {
    List<String> suggestions = [];

    // search text
    if (searchText.isNotEmpty) {
      final localApps = widget.state.localApps;
      for (final app in localApps) {
        if (app.name.isCaseInsensitiveContains(searchText)) {
          suggestions.add(app.name.toLowerCase());
        }
      }
    }

    if (suggestions.length < 3) {
      return [];
    }

    return suggestions;
  }

  void rebuild() {
    if (mounted) {
      setState(() {});
    }
  }
}
