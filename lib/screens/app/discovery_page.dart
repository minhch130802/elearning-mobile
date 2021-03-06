import 'package:elearning_project/widgets/category_tile.dart';
import 'package:elearning_project/bloc/course_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with AutomaticKeepAliveClientMixin<DiscoveryPage> {

  final CourseBloc _courseBloc = CourseBloc();

  @mustCallSuper
  void initState() {
    _courseBloc.add(GetHomeCategoryList(0, ''));
    super.initState();
  }

  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    return BlocProvider(
        create: (_) => _courseBloc,
        child: BlocListener<CourseBloc, CourseState>(
          listener: (context, state) {
            if (state is CourseError) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
          child: BlocBuilder<CourseBloc, CourseState>(
                  builder: (context, state) {
                    if (state is CourseInitial) {
                      return LoadingIndicator();
                    }

                    if (state is CourseLoading) {
                      return LoadingIndicator();
                    }

                    if (state is CourseHomeLoaded) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          _courseBloc.add(GetHomeCategoryList(0, ''));
                        },
                        child: GridView.count(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          crossAxisCount: 2,
                          childAspectRatio: itemWidth / 255,
                          children: state.data.map<Widget>((item) {
                            return CategoryTile(id: item.id, name: item.name);
                          }).toList(),
                        ),
                      );
                    }

                    return Container();
                  }
              ),
        )
    );
  }

  @mustCallSuper
  bool get wantKeepAlive => true;
}
