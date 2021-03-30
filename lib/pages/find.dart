import 'package:flutter/material.dart';
// import '../imageListDetails/imageListDetails.dart';

List<Map> listData = [
  {
    'id': 1,
    'url': 'images/1.jpg',
    'title': '100',
    'opacity': 0.3,
    'checked': true,
  },
  {
    'id': 2,
    'url': 'images/2.jpg',
    'title': '200',
    'opacity': 0.5,
    'checked': false,
  },
  {
    'id': 3,
    'url': 'images/3.jpg',
    'title': '300',
    'opacity': 0.7,
    'checked': false,
  },
  {
    'id': 4,
    'url': 'images/4.jpg',
    'title': '300',
    'opacity': 0.9,
    'checked': false,
  },
];
final sortList = ['热门推荐', '手机数码', '电脑办公', '家用电器', '精选日用'];

class ThemeColors {
  ///第一行背景色
  static Color colorFirst = Color.fromRGBO(219, 112, 147, 1);
}

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> with SingleTickerProviderStateMixin {
  //控制器
  var controller = new ScrollController();

  var selectTab = 0;
  var tagTab = 0;

  void clickLi(id) {
    setState(() {
      listData.forEach((element) {
        if (element['id'] == id) {
          element['checked'] = true;
        } else {
          element['checked'] = false;
        }
      });
    });
  }

  void clickTab(idx) {
    setState(() {
      selectTab = idx;
    });
  }

  void clickTag(idx) {
    setState(() {
      tagTab = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final obj =
    //     ModalRoute.of(context).settings.arguments as Map<String, Object>;

    return Scaffold(
      appBar: AppBar(
        // title: Text('参数是：' + obj['t']),
        title: Text('分类'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          sortPart(),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                //头部tag
                SliverPersistentHeader(
                  pinned: true, //固定
                  delegate: MySliverPersistentHeaderDelegate(
                    child: getTag(),
                  ),
                ),

                //底部分类,
                // SliverFixedExtentList(
                //   itemExtent: 50.0,
                //   delegate: SliverChildBuilderDelegate(
                //     (BuildContext context, int index) {
                //       return Container(
                //         alignment: Alignment.center,
                //         // color: Colors.lightBlue[100 * (index % 9)],
                //         child: getSliverGrid(listData),
                //       );
                //     },
                //     childCount: 10,
                //   ),
                // ),

                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('标题'),
                            getSliverGrid(listData)
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 左边
  Widget sortPart() {
    return Container(
      width: 80,
      height: MediaQuery.of(context).size.height,
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: sortList.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              width: 80,
              height: 45,
              padding: EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: selectTab == index ? Colors.orange : Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: Text(
                sortList[index],
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14.0,
                  color: selectTab == index ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: () {
              clickTab(index);
            },
          );
        },
      ),
    );
  }

  Widget getTag() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: OutlineButton(
            borderSide: BorderSide(
              color: tagTab == index ? Colors.orange : Colors.grey[400],
            ),
            child: Text(
              '商品分类',
              style: TextStyle(
                fontSize: tagTab == index ? 14 : 12,
              ),
            ),
            textColor: tagTab == index ? Colors.orange : Colors.black,
            shape: StadiumBorder(),
            splashColor: Colors.blue,
            highlightColor: Colors.grey[200],
            onPressed: () {
              clickTag(index);
              print(tagTab);
              // this.controller.animateTo(
              //       1400,
              //       duration: new Duration(milliseconds: 300), // 300ms
              //       curve: Curves.bounceIn,
              //     );
            },
          ),
        );
      },
    );
  }

  List<Widget> getWidgetList(arr) {
    var templateList = arr.map<Widget>((item) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    item['url'],
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
              child: Text("1111"),
            )
          ],
        ),
      );
    });

    return templateList.toList();
  }

  // 网格
  Widget getSliverGrid(List arr) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      //水平子Widget之间间距
      crossAxisSpacing: 10.0,
      //垂直子Widget之间间距
      mainAxisSpacing: 10.0,
      //GridView内边距
      padding: EdgeInsets.all(10.0),
      //一行的Widget数量
      crossAxisCount: 3,
      //子Widget宽高比例
      childAspectRatio: 2.0,
      //子Widget列表
      children: getWidgetList(arr),
    );
  }
}

// tag的list
class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final ListView child;

  MySliverPersistentHeaderDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50,
      color: Colors.white,
      child: child,
    );
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      true; // 如果内容需要更新，设置为true
}
