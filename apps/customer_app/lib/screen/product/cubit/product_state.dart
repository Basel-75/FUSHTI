part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}


final class CartThereState extends ProductState {}
final class DoneAddState extends ProductState {}
