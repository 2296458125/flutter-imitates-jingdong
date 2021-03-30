import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hellow_world/iconfont/icon_font.dart';
import '../components/screenApdar.dart';
import 'list/goodsList.dart';

class Classification extends StatefulWidget {
  Classification({Key key}) : super(key: key);

  @override
  _ClassificationState createState() => _ClassificationState();
}

class _ClassificationState extends State<Classification> {
  ScrollController _scrollController;
  ScrollController _singleController;
  ScrollController _tagController;
  int _currentIndex = 0;
  int _tagIndex = 0;
  var _girdSize;
  var allHeightList = [];
  var _currentHeightList = [];
  double allHeight;
  bool isScrollController = true;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _singleController = ScrollController();
    _tagController = ScrollController();
    _tagController.addListener(() {
      // 监听滚动
      print(_singleController.offset);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //每个GridView的高度
    _girdSize = (MediaQuery.of(context).size.width * 0.7 - 22) / 3 * 1.2;
    //每一块GridView所占的高度放入数组
    listData[_currentIndex]["list"].forEach((val) {
      allHeightList.add((val["list"].length / 3).ceil() * _girdSize);
    });
    _singleController.addListener(() {
      print(_singleController.offset);
      allHeightList
          .sublist(0, _tagIndex + 1)
          .reduce((value, element) => value + element);
      var zero = listData[_currentIndex]["swiperImage"] == null ? 0 : 100;
      if (_singleController.offset <
          (zero +
              allHeightList
                  .sublist(0, 1)
                  .reduce((value, element) => value + element))) {
        setState(() {
          _tagIndex = 0;
        });
      }
      while (_singleController.offset >=
          (zero +
              (_tagIndex + 1) * 20 -
              30 +
              allHeightList
                  .sublist(0, _tagIndex + 1)
                  .reduce((value, element) => value + element))) {
        setState(() {
          _tagIndex = _tagIndex + 1;
        });
        return;
      }
      if (_tagIndex != 0) {
        while (_singleController.offset <
            (zero -
                30 +
                _tagIndex * 20 +
                allHeightList
                    .sublist(0, _tagIndex)
                    .reduce((value, element) => value + element))) {
          setState(() {
            _tagIndex = _tagIndex - 1;
          });
        }
      }
      _tagController.animateTo(_tagIndex * 90.0 + _tagIndex * 10,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _singleController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  //头部组件
  Widget _getHeaderWidget() {
    return AppBar(
      leading: Center(
        child: IconFont(
          IconNames.saoyisao,
          size: 28,
        ),
      ),
      title: Container(
        height: 32,
        decoration: BoxDecoration(
            color: Color(0xfff7f7f7),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextField(
          decoration: InputDecoration(
            focusColor: Colors.grey,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            contentPadding: EdgeInsets.all(0),
            hintText: "请输入商品",
            hintStyle: TextStyle(fontSize: ScreenApdar.setFontSize(20)),
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
      actions: [
        Container(
          width: 35,
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.message,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
      backgroundColor: Color(0xffe6e6e6),
    );
  }

  //左侧组件
  Widget _getLeftWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.3,
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => {
              setState(() => {
                    _currentIndex = index,
                    _tagIndex = 0,
                    _scrollController.animateTo(_currentIndex * 50.0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease)
                  })
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color:
                      _currentIndex == index ? Colors.white : Color(0xffe6e6e6),
                  borderRadius: _currentIndex == index
                      ? BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))
                      : BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
              child: Center(
                child: Text(
                  listData[index]["text"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: _currentIndex == index ? 16 : 14,
                      fontWeight: _currentIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ),
            ),
          );
        },
        itemCount: listData.length,
      ),
    );
  }

  //右侧组件
  Widget _getRightWidget() {
    return Expanded(
        flex: 1,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            // primary: true,
            controller: _singleController,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: _getswiperWidget(listData[_currentIndex]["swiperImage"]),
              ),
              listData[_currentIndex]["list"] == null
                  ? SliverToBoxAdapter()
                  : SliverPersistentHeader(
                      delegate: MySliverPersistentHeaderDelegate(
                          child:
                              _getHeaderTags(listData[_currentIndex]["list"])),
                      pinned: true),
              SliverList(
                  delegate:
                      SliverChildListDelegate([..._getClassificatinList()]))
            ],
          ),
        ));
  }

  //轮播图
  Widget _getswiperWidget(List swiper) {
    if (swiper == null) {
      return Container();
    } else {
      return Container(
        height: 100,
        // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Swiper(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          pagination: SwiperPagination(),
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                      image: NetworkImage(swiper[index]["url"]),
                      fit: BoxFit.fill)),
            );
            // return ClipRRect(
            //   borderRadius: BorderRadius.all(Radius.circular(15)),
            //   child: Image.network(
            //     swiper[index]["url"],
            //     fit: BoxFit.fill,
            //   ),
            // );
          },
        ),
      );
    }
  }

//网格列表
  List<Widget> _getGridList(List number) {
    var templateList = number.map<Widget>((item) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(item["url"]), fit: BoxFit.fill)),
            ),
            Center(
              child: Text(item["name"]),
            )
          ],
        ),
      );
    });
    return templateList.toList();
  }

  //分类网格
  Widget _getGridViewWidget(List array) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      childAspectRatio: 1 / 1.2,
      children: _getGridList(array),
    );
  }

  //标题
  Widget _getTitleWidget(String text) {
    return Container(
      width: double.infinity,
      height: 20,
      child: Text(
        text,
        textAlign: TextAlign.start,
      ),
    );
  }

  //最终网格列表
  List<Widget> _getClassificatinList() {
    if (listData[_currentIndex]["list"] == null) {
      return <Widget>[
        Container(
            child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/wu.png"), fit: BoxFit.contain)),
            )
          ],
        ))
      ];
    } else {
      return listData[_currentIndex]["list"]?.map<Widget>((item) {
        return Container(
          child: Column(
            children: <Widget>[
              _getTitleWidget(item["name"]),
              _getGridViewWidget(item["list"])
            ],
          ),
        );
      })?.toList();
    }
  }

  //头部导航标签
  Widget _getHeaderTags(List array) {
    return Container(
      // height: 35,
      margin: EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        controller: _tagController,
        itemCount: array.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => {
              setState(() {
                _tagIndex = index;
                _tagController.animateTo(_tagIndex * 90.0 + _tagIndex * 10,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
                //当前tag之前的GridView所占高度List
                _currentHeightList =
                    allHeightList.sublist(0, _tagIndex == 0 ? 1 : _tagIndex);
                //累加得出需要滚动的高度
                allHeight = _currentHeightList
                    .reduce((value, element) => value + element);
                //控制滚动
                if (listData[_currentIndex]["swiperImage"] == null) {
                  _singleController.jumpTo(
                    _tagIndex == 0 ? 0 : allHeight + _tagIndex * 20,
                  );
                } else {
                  _singleController.jumpTo(
                    (_tagIndex == 0 ? 0 : allHeight + _tagIndex * 20) + 100.0,
                  );
                }
              })
            },
            child: Container(
              constraints: BoxConstraints(minWidth: 90),
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color:
                    _tagIndex == index ? Color(0x3Ffa6668) : Color(0xffe6e6e6),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: _tagIndex == index
                    ? Border.all(color: Colors.red, width: 1)
                    : Border(),
              ),
              child: Center(
                child: Text(
                  array[index]["name"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _tagIndex == index ? Colors.red : Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenApdar.init(context);
    return Scaffold(
      appBar: _getHeaderWidget(),
      backgroundColor: Color(0xffe6e6e6),
      body: Row(
        children: [_getLeftWidget(), _getRightWidget()],
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Container child;

  MySliverPersistentHeaderDelegate({@required this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 55,
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: this.child,
    );
  }

  @override
  double get maxExtent => 55;

  @override
  double get minExtent => 55;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
