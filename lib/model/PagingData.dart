class PagingData<T> {

  bool hasNext;
  List<T> data;
  int nextPage;

  PagingData(this.hasNext, this.data);
}
