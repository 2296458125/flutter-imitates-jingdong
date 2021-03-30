import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'list/goodsList.dart';

class ShoppingCar extends StatefulWidget {
  ShoppingCar({Key key}) : super(key: key);

  @override
  _ShoppingCarState createState() => _ShoppingCarState();
}

class _ShoppingCarState extends State<ShoppingCar>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController controller;
  bool _isSelected = false;
  double total = 0.0;
  List<Map> shoppingCarList = shoppingList;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  // 计算合计
  double getTotal(List data) {
    double result = 0.0;
    for (var i = 0; i < data.length; i++) {
      if (data[i]["goodslist"] != null) {
        for (var j = 0; j < data[i]["goodslist"].length; j++) {
          if (data[i]["goodslist"][j]["selected"] == true &&
              data[i]["goodslist"][j]["price"] != null) {
            result = result +
                double.parse(data[i]["goodslist"][j]["price"]) *
                    double.parse(data[i]["goodslist"][j]["number"]);
            print("计算$result");
          }
        }
        print("来来$result");
        // reduce(data[i]["goodslist"], result);
      }
    }
    print("最后结果$result");
    return result;
  }

  //底部全选
  void getAllcheck() {
    shoppingCarList.forEach((item) {
      item["selected"] = _isSelected;
      item["goodslist"].forEach((val) {
        val["selected"] = _isSelected;
      });
    });
  }

  //单个店铺全选和反选
  void aAllCheck() {
    shoppingCarList.forEach((item) {
      item["selected"] = item["goodslist"].every((e) => e["selected"] == true);
    });
  }

  //底部反选
  void getAntiCheck() {
    _isSelected = shoppingCarList.every((e) => e["selected"] == true);
  }

  //购物车卡片
  List<Widget> _getShoppingCard(List cardList) {
    if (cardList.length == 0) {
      return <Widget>[Container()];
    } else {
      var templateList = cardList.map<Widget>((item) {
        return Card(
          color: Colors.white,
          shadowColor: Colors.black45,
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Checkbox(
                      value: item["selected"],
                      tristate: false,
                      activeColor: Color.fromARGB(255, 255, 67, 78),
                      checkColor: Colors.white,
                      onChanged: (bool isChecked) {
                        setState(() {
                          item["selected"] = isChecked;
                          item["goodslist"].forEach((val) {
                            val["selected"] = isChecked;
                          });
                          total = getTotal(shoppingCarList);
                          getAntiCheck();
                        });
                      }),
                  Text(item["shopName"]),
                ],
              ),
              Baseline(
                baseline: 1,
                baselineType: TextBaseline.alphabetic,
                child: Container(
                  color: Color(0xFFededed),
                  height: 1,
                  width: double.infinity,
                ),
              ),
              Column(
                children: [..._getShoppingCarGoods(item["goodslist"])],
              )
            ],
          ),
        );
      });
      return templateList.toList();
    }
  }

  //购物车商品
  List<Widget> _getShoppingCarGoods(List goodsList) {
    if (goodsList == null) {
      return <Widget>[Container()];
    } else {
      var newList = goodsList.map<Widget>((item) {
        return Container(
          height: 111,
          child: Row(
            children: <Widget>[
              Checkbox(
                  value: item["selected"],
                  activeColor: Color.fromARGB(255, 255, 67, 78),
                  checkColor: Colors.white,
                  onChanged: (bool isChecked) {
                    setState(() {
                      item["selected"] = isChecked;
                      total = getTotal(shoppingCarList);
                      aAllCheck();
                      getAntiCheck();
                    });
                  }),
              Image.network(
                item["url"],
                fit: BoxFit.fill,
                width: 80,
                height: 80,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item["name"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            item["subtitle"],
                            softWrap: false,
                            style: TextStyle(color: Color(0xff999999)),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "￥${item['price']}",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16),
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 15,
                                        child: IconButton(
                                            iconSize: 14,
                                            padding: EdgeInsets.all(0),
                                            color: item["number"] == "1"
                                                ? Colors.grey
                                                : Colors.black,
                                            icon: Icon(Icons.remove),
                                            onPressed: item["number"] == "1"
                                                ? null
                                                : () {
                                                    setState(() {
                                                      item["number"] =
                                                          (int.parse(item[
                                                                      "number"]) -
                                                                  1)
                                                              .toString();
                                                      total = getTotal(
                                                          shoppingCarList);
                                                    });
                                                  }),
                                      ),
                                      Container(
                                        width: 40,
                                        height: 20,
                                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        color: Color(0xfff2f2f2),
                                        child: Center(
                                          child: Text(
                                            item["number"],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 15,
                                        child: IconButton(
                                            iconSize: 14,
                                            padding: EdgeInsets.all(0),
                                            color: Colors.black,
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                item["number"] =
                                                    (int.parse(item["number"]) +
                                                            1)
                                                        .toString();
                                                total =
                                                    getTotal(shoppingCarList);
                                              });
                                            }),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      });
      return newList.toList();
    }
  }

  //购物车list
  Widget _getShoppingList(List list) {
    return Column(
      children: [
        Expanded(
            child: Container(
          child: ListView(
            children: [..._getShoppingCard(list)],
          ),
        )),
        Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 1),
            child: Row(
              children: [
                Checkbox(
                    value: _isSelected,
                    onChanged: (bool isChecked) {
                      setState(() {
                        _isSelected = isChecked;
                        getAllcheck();
                        total = getTotal(shoppingCarList);
                      });
                    }),
                Text("全选"),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          "不含运费 ",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          "合计:",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          "￥$total",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "结算($total)",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        width: 130,
                        height: 50,
                        color: Colors.red,
                      )
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6e6e6),
      appBar: AppBar(
        title: Container(
          child: Column(
            children: [
              Text("购物车", style: TextStyle(color: Colors.black)),
              Text("配送至凌塘村3554",
                  style: TextStyle(color: Colors.black38, fontSize: 12))
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffe6e6e6),
        actions: [
          Container(
            child: Center(
              child: Text(
                "编辑",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        textStyle: TextStyle(color: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              child: Icon(
                                Icons.message,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              height: 30,
                              child: Text(
                                "消息",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ))
                  ])
        ],
        bottom: TabBar(
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
            tabs: [
              Tab(
                text: "全部(10)",
              ),
              Tab(
                text: "降价(5)",
              ),
              Tab(
                text: "常买(5)",
              ),
              Tab(
                text: "分类",
              ),
            ]),
      ),
      body: TabBarView(controller: this.controller, children: [
        ...List.generate(4, (index) => _getShoppingList(shoppingCarList))
      ]),
    );
  }
}
