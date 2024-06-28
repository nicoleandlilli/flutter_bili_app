import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/core/hi_state.dart';
import 'package:flutter_bili_app/util/color.dart';

import '../http/core/hi_error.dart';
import '../util/toast.dart';

///通用底层带分页和刷新的页面框架
///M为Dao返回数据模型，L为列表数据模型，T为具体widget
abstract class HiBaseTabState<M, L,T extends StatefulWidget> extends HiState<T>
    with WidgetsBindingObserver{

  List<L> dataList = [];
  int pageIndex = 1;
  bool loading = false;
  ScrollController _scrollController = ScrollController();
  late Widget _currentPage;

  get contentChild ;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      var dis = _scrollController.position.maxScrollExtent -
      _scrollController.position.pixels;
      if (kDebugMode) {
        print('dis:$dis');
      }
      //当距离底部不足300时加载更多
      if(dis<300&&!loading){
        if (kDebugMode) {
          print('-------_loadData------------');
        }
        loadData(loadMore: true);
      }
      WidgetsBinding.instance.addObserver(this);
    });

    loadData();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: primary,
      onRefresh: loadData,
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: contentChild),
        );
  }


  ///获取对应页码的数据
  Future<M> getData(int pageIndex);

  ///从MO中解析出list数据
  List<L> pareList(M result);


  Future<void> loadData({loadMore = false}) async{
    if(loading){
      if (kDebugMode) {
        print('上次加载还没完成...');
      }
      return;
    }
    loading = true;
    if(!loadMore){
      pageIndex = 1;
    }
    var currentIndex = pageIndex +(loadMore ? 1:0);
    if (kDebugMode) {
      print('loading:currentIndex:$currentIndex');
    }

    try{
      var result = await getData(currentIndex);
      setState(() {
        if(loadMore){
          //合成一个新数组
          dataList = [...dataList,...pareList(result)];
          if(pareList(result).isNotEmpty){
            pageIndex++;
          }
        }else{
          dataList = pareList(result);
        }
      });
    }on NeedAuth catch(e){
      if (kDebugMode) {
        print(e);
      }
      showWarnToast(e.message);
    }on HiNetError catch(e){
      if (kDebugMode) {
        print(e);
      }
      showWarnToast(e.message);
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      showWarnToast(e.toString());
    }

  }
  @override
  bool get wantKeepAlive => true;
}