import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SubNStdShimmerEffect extends StatelessWidget {
  const SubNStdShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: placeHolderRow(),
            ),
          ),
        ),
      ],
    );
  }

  Widget placeHolderRow() => Padding(
    padding: const EdgeInsets.fromLTRB(5, 12, 5, 0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 53,
          width: 65,
          color: Colors.white,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 10.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 3.0),
              ),
              Container(
                width: double.infinity,
                height: 10.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 3.0),
              ),
              Container(
                width: 60.0,
                height: 8.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class AttendanceShimmerEffect extends StatelessWidget {
  const AttendanceShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: placeHolderRow(),
            ),
          ),
        ),
      ],
    );
  }

  Widget placeHolderRow() => Padding(
    padding: const EdgeInsets.fromLTRB(5,12,5,0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Container(
                width: double.infinity,
                height: 10.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 3.0),
              ),
              Container(
                width: double.infinity,
                height: 10.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 3.0),
              ),
              Container(
                width: 80.0,
                height: 8.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
        ),
        Container(
          height: 53,
          width: 65,
          color: Colors.white,
        ),
      ],
    ),
  );
}

class HistoryShimmerEffect extends StatelessWidget {
  const HistoryShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: placeHolderRow(),
            ),
          ),
        ),
      ],
    );
  }

  Widget placeHolderRow() => Padding(
    padding: const EdgeInsets.fromLTRB(5, 12, 5, 0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 28,
          width: 28,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle

          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 6.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 1.0),
              ),
              Container(
                width: double.infinity,
                height: 6.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 1.0),
              ),
              Container(
                width: 60.0,
                height: 6.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}