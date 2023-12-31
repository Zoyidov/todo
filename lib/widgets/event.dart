import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/icons.dart';

class Event extends StatefulWidget {
  final Color color;
  final Color tColor;
  final String name;
  final String description;
  final String location;
  final String time;

  const Event({
    Key? key,
    required this.color,
    required this.name,
    required this.description,
    required this.location,
    required this.time,
    required this.tColor,
  }) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: widget.color,
            ),
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: widget.color.withOpacity(0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: widget.tColor,
                    ),
                  ),
                  Text(
                    widget.description.length <= 30
                        ? widget.description
                        : '${widget.description.substring(0, 100)}...',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                      color: widget.tColor,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      if (widget.time.isNotEmpty)
                        Row(
                          children: [
                            // ignore: deprecated_member_use
                            SvgPicture.asset(AppIcons.clock,
                                // ignore: deprecated_member_use
                                color: widget.color),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.time,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: widget.tColor,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      if (widget.location.isNotEmpty)
                        Row(
                          children: [
                            // ignore: deprecated_member_use
                            SvgPicture.asset(AppIcons.location,
                                // ignore: deprecated_member_use
                                color: widget.color),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.location.length <= 20
                                  ? widget.location
                                  : '${widget.location.substring(0, 20)}...',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: widget.tColor,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
