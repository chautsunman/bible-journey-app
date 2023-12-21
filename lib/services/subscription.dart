abstract class Subscriber<T> {
  void onData(T data);
}

abstract class Publisher<T> {
  void subscribe(Subscriber<T> subscriber);
  void unsubscribe(Subscriber<T> subscriber);
}

class SubscriberImpl<T> extends Subscriber<T> {
  final void Function(T data) callback;

  SubscriberImpl(this.callback);

  @override
  void onData(T data) {
    callback(data);
  }
}
