import 'package:equatable/equatable.dart';

class Loading extends Equatable {
  final bool isLoading;
  final bool isLoadSuccess;
  final dynamic loadError;

  const Loading({
    required this.isLoading,
    required this.isLoadSuccess,
    required this.loadError,
  });

  factory Loading.initial() {
    return const Loading(
      isLoading: false,
      isLoadSuccess: false,
      loadError: false,
    );
  }

  Loading copyWith({
    bool? isLoading,
    bool? isLoadSuccess,
    dynamic loadError,
  }) {
    return Loading(
      isLoading: isLoading ?? this.isLoading,
      isLoadSuccess: isLoadSuccess ?? this.isLoadSuccess,
      loadError: loadError ?? this.loadError,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoadSuccess,
        loadError,
      ];

  factory Loading.fromJson(Map<String, dynamic> json) => Loading(
        isLoading: json["isLoading"],
        isLoadSuccess: json["isLoadSuccess"],
        loadError: json["loadError"],
      );

  Map<String, dynamic> toJson() => {
        "isLoading": isLoading,
        "isLoadSuccess": isLoadSuccess,
        "loadError": loadError,
      };
}
