import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hellow_world/iconfont/icon_font.dart';
import '../components/screenApdar.dart';
import 'list/goodsList.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget _getScrollWidget() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            leading: Center(
              child: IconFont(
                IconNames.jingdongicon,
                size: 30,
              ),
            ),
            centerTitle: true,
            expandedHeight: 110,
            collapsedHeight: 60,
            actions: <Widget>[
              Container(
                width: 35,
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.crop_free,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Container(
                width: 35,
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                height: 25,
                width: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: "请输入商品",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintStyle: TextStyle(fontSize: ScreenApdar.setFontSize(16)),
                    prefixIcon: Icon(Icons.search,
                        size: ScreenApdar.setFontSize(30), color: Colors.grey),
                    suffixIcon: Icon(Icons.camera_alt,
                        size: ScreenApdar.setFontSize(30), color: Colors.grey),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
              ),
            ),
            floating: false,
            pinned: true,
            snap: false,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _headTabBarWidget(),
                _swiperWidget(),
                _girdMenuWidget(),
                _getListViewWidget()
              ],
            ),
          ),
          SliverPersistentHeader(
            delegate: MySliverPersistentHeaderDelegate(
              child: TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                unselectedLabelStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                controller: this.controller,
                tabs: <Widget>[
                  Tab(text: "女装"),
                  Tab(text: "男装"),
                  Tab(text: "童装"),
                ],
              ),
            ),
            pinned: true,
          ),
        ];
      },
      body: TabBarView(
        children: [
          _getStaggeredView(goodsWomenList),
          _getStaggeredView(goodsMenList),
          _getStaggeredView(goodsChildList),
        ],
        controller: this.controller,
      ),
    );
  }

  //头部导航切换
  Widget _headTabBarWidget() {
    return DefaultTabController(
      length: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 10,
              child: Container(
                color: Colors.red,
                child: TabBar(
                  tabs: <Widget>[
                    Tab(text: "首页"),
                    Tab(text: "手机"),
                    Tab(text: "食品"),
                    Tab(text: "家电"),
                    Tab(text: "生鲜"),
                    Tab(text: "家装"),
                    Tab(text: "运动"),
                    Tab(text: "电脑办公"),
                    Tab(text: "家居厨房"),
                    Tab(text: "美妆"),
                    Tab(text: "母婴童装"),
                    Tab(text: "个护清洁"),
                    Tab(text: "男装"),
                    Tab(text: "女装"),
                    Tab(text: "图书"),
                  ],
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 35,
                      child: IconButton(
                          icon: Icon(
                            Icons.apps,
                            color: Colors.white,
                          ),
                          onPressed: null),
                    ),
                    Container(
                      width: 35,
                      child: Text("分类",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  //轮播图
  Widget _swiperWidget() {
    List<Map> imageList = [
      {"url": "images/6.jpg"},
      {"url": "images/7.jpg"},
      {"url": "images/8.jpg"}
    ];
    return Stack(
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
        ),
        Container(
          height: 250,
          // decoration: BoxDecoration(color: Colors.red),
          child: Swiper(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            pagination: SwiperPagination(),
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                        image: AssetImage(
                          imageList[index]["url"],
                        ),
                        fit: BoxFit.cover)),
                height: 250,
              );
            },
          ),
        )
      ],
    );
  }

  List<Widget> _getGridList(int number) {
    var newListData = listData.sublist(number - 10, number);
    var templateList = newListData.map((item) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: IconButton(
                  icon: IconFont(item["icon"], size: 36), onPressed: null),
            ),
            Center(
              child: Text(item["text"]),
            )
          ],
        ),
      );
    });
    return templateList.toList();
  }

  //中间网格菜单
  Widget _girdMenuWidget() {
    return Container(
      height: 200,
      child: PageView(
        children: [
          Container(
            child: GridView.count(
              crossAxisCount: 5,
              crossAxisSpacing: 10.0,
              padding: EdgeInsets.all(10),
              mainAxisSpacing: 10,
              children: _getGridList(10),
            ),
          ),
          Container(
            child: GridView.count(
              crossAxisCount: 5,
              crossAxisSpacing: 10.0,
              padding: EdgeInsets.all(10),
              mainAxisSpacing: 10,
              children: _getGridList(20),
            ),
          )
        ],
      ),
    );
  }

  List<Map> listViewData = [
    {"url": "images/1.jpg"},
    {"url": "images/2.jpg"},
    {"url": "images/3.jpg"},
    {"url": "images/4.jpg"},
  ];
  //横向滚动列表
  Widget _getListViewWidget() {
    return Container(
      height: 200,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(flex: 2, child: Text("京东秒杀")),
                Expanded(flex: 7, child: Text("倒计时")),
                // Expanded(flex: 2, child: Text("更多秒杀")),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        icon:
                            IconFont(IconNames.rightbutton_fill, color: "red"),
                        onPressed: null)),
              ],
            ),
          ),
          Container(
            height: 150,
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 120,
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(listViewData[index]["url"]),
                                  fit: BoxFit.cover)),
                        ),
                        Center(
                          child: Text("￥25",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Center(
                          child: Text("￥38.8",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffcdcdcd))),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _getStaggeredView(List goodsList) {
    return Container(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        padding: EdgeInsets.all(10),
        itemCount: goodsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: [
                Expanded(
                    flex: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(goodsList[index]["url"]),
                            fit: BoxFit.fill),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(goodsList[index]["name"],
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        "￥${goodsList[index]["price"]}",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ))
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
          );
        },
        staggeredTileBuilder: (int index) {
          return StaggeredTile.count(2, index.isEven ? 2.5 : 3);
        },
        mainAxisSpacing: 10,
        crossAxisSpacing: 10.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenApdar.init(context);
    return Scaffold(
      body: _getScrollWidget(),
      backgroundColor: Color(0xffe6e6e6),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  MySliverPersistentHeaderDelegate({@required this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 80,
      color: Colors.white,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height + 30;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
