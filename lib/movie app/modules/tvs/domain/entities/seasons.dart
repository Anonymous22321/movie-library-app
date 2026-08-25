import 'package:equatable/equatable.dart';

import 'episodes.dart';

abstract class Season extends Equatable{
  final String name;
 final List<Episodes> episodes;
 final int seasonId;

  const Season({
    required this.name,
    required this.episodes,
    required this.seasonId,
  });
  @override
  List<Object> get props => [
    name,
    episodes,
    seasonId,
  ];
}