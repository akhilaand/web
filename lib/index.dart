import 'package:flutter/material.dart';
class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin{
  bool doChange=false;
  ScrollController? _scrollController=ScrollController();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );
  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _scrollController?.addListener(() {
      print(_scrollController!.position.atEdge);

        // print("nothing much");
        if (_scrollController!.position.pixels >=10) {
         setState(() {
           _controller.forward();
           doChange=true;

         });
        } else if(_scrollController!.position.pixels <=40) {
          setState(() {
            _controller.reverse();
            doChange=false;
          });

      }
    });
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    // print(_scrollController!.position.pixels);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer:Drawer(),
        body: Column(
          children: [
            doChange?Align(
              alignment: Alignment.centerRight,
              child: FadeTransition(
                opacity:_animation ,
                child: Container(
                  color: Colors.transparent,
                  child: Container(
                    color: Colors.blue,
                    width:size.width ,
                    height: 50,
                    child: IconButton(onPressed: (){_scaffoldKey.currentState!.openEndDrawer();}, icon: Icon(Icons.accessibility)),
                  ),
                ),
              ),
            ):Container(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                controller:_scrollController,
                children: [
                  Container(
                   height: 550,
                    color: Colors.red,
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Container(

                      height: 550,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  }
}
