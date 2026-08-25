import 'package:equatable/equatable.dart';

abstract class Episodes  extends Equatable{
  const Episodes({
    required this.name,
    required this.overview,
    required this.stillPath,
    required this.airDate,
    required this.episodeNumber,
    required this.seasonNumber,
    required this.episodeId,
  });

  final String name,overview,stillPath,airDate;
  final int episodeNumber,seasonNumber,episodeId;

  @override
  List<Object> get props => [
    name,
    overview,
    stillPath,
    airDate,
    episodeNumber,
    seasonNumber,
    episodeId,
  ];





}