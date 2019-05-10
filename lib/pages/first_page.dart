import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:us_stock/stock_list_item.dart';

class FirstPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FirstPageState();
  }
}
class _FirstPageState extends State<FirstPage>{

  static final iuImagePath =
      "https://vignette.wikia.nocookie.net/justdance/images/4/4c/IU.jpg/revision/latest?cb=20170705185753";

  static final iuImagePath2 =
      "https://kprofiles.com/wp-content/uploads/2016/09/IU.jpg";
  static final iuImagePath3 =
      "https://kathynguyen2.files.wordpress.com/2017/04/is-iu-finally-coming-back-as-a-singer1.jpg?w=1180";
  static final iuImagePath4 =
      "https://channel-korea.com/wp-content/uploads/2017/09/IU_1476317492_af_org-e1506689157858.jpg";
  static final iuImagePath5 =
      "https://img.kpopmap.com/2018/09/IU-lee-sun-gyun.jpg";
  static final iuImagePath6 =
      "https://media0.giphy.com/media/rip1YZlLN4mwo/source.gif";
  static final iuImagePath7 =
      "https://www.allkpop.com/upload/2018/10/af_org/27105129/IU.jpg";
  static final iuImagePath8 =
      "https://0.soompi.io/wp-content/uploads/2017/10/22073014/IU-1.jpg?s=900x600&e=t";

  List<String> imagePathList = [
    iuImagePath,
    iuImagePath2,
    iuImagePath3,
    iuImagePath4,
    iuImagePath5,
    iuImagePath6,
    iuImagePath7,
    iuImagePath8,
  ];

  int _counter = 0;

  void _addCounter(){
    setState(() {
      _counter++;
    });

  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[GestureDetector(
            onTap: _addCounter,
            child: Text("counter: $_counter"),
          ),
            StockListItem("Tencent"),
            SizedBox(
              height: 10,
            ),
            StockListItem("Apple"),
            SizedBox(
              height: 10,
            ),
            StockListItem("Jumia"),
            SizedBox(
              height: 10,
            ),
            StockListItem("SiuMi"),
            SizedBox(
              height: 10,
            ),
            AspectRatio(
              child: CachedNetworkImage(
                imageUrl: imagePathList[index],
                fit: BoxFit.cover,
                placeholder: Image(
                  image: AssetImage("assets/images/placeholder.png"),
                  fit: BoxFit.cover,
                ),
                errorWidget: Icon(Icons.error),
              ),
              aspectRatio: 16 / 9,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Column(
                  children: <Widget>[
                    Text(
                      "沙中綫聆訊第42日，庭上繼續就鋼筋扭入螺絲帽的標準爭拗。中科興業委聘的獨立結構工程專家、港大土木工程系副教授楊德忠作供時指出，鋼筋絞牙真正長度最長可達48毫米，並根據其標準重新計算，認為現時已公佈的開鑿檢測結果約有6成不合格，對結構完整性存疑。",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    )
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.favorite),
                Icon(Icons.view_day),
                Icon(Icons.bookmark),
                Icon(Icons.photo)
              ],
            ),
            ButtonTheme(
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("RasiedButton"),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text("FlatButton"),
                    onPressed: () {},
                  ),
                  Card(
                    child: Text("Card"),
                  ),
                ],
              ),
            )
          ],
        );
      },
      itemCount: imagePathList.length,
      padding: EdgeInsets.all(20.0),
    );;
  }

}