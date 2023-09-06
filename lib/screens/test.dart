import 'package:flutter/material.dart';

void main() => runApp(FilterButton());

class FilterButton extends StatefulWidget {
  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton>
    with SingleTickerProviderStateMixin {
  bool _isFiltered = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('My App'),
            pinned: true,
            floating: true,
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                const Tab(text: 'Tab 1'),
                const Tab(text: 'Tab 2'),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Content for Tab 1
                const Center(
                  child: Text('Tab 1 Content'),
                ),
                // Content for Tab 2
                const Center(
                  child: Text('Tab 2 Content'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
