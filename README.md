# Entity State

Entity State to manage records in your redux state.

## Installation

Add this to your project's pubspec.yaml

```
dependencies:
  entity_state: ^1.2.5
```

## Usage

In your redux state

```
abstract class ReminderState
    with EntityState<Reminder, int, ReminderState, ReminderStateBuilder>
    implements Built<ReminderState, ReminderStateBuilder> {
  // This is mandatory to add
  BuiltList<int> get ids;

  // This is mandatory to add
  BuiltMap<int, Reminder> get entities;

  ReminderState._();

  factory ReminderState([updates(ReminderStateBuilder b)]) = _$ReminderState;

  static Serializer<ReminderState> get serializer => _$reminderStateSerializer;
  
  // This will tell the entity state what is the unique identifier of the model.
  @override
    int getId(Reminder data) {
      return data.id;
    }
}
```

In your reducer

### To Add One

```
AppNotificationState listNotificationComplete(
    AppNotificationState appNotificationState,
    ListNotificationComplete action) {
  return appNotificationState
        // action.notification is `Notification`
      .addOne(action.notification)
      .rebuild((b) => b..isLoading = false);
}
```

### To Add All (replaces any data that was previously present)

```
AppNotificationState listNotificationComplete(
    AppNotificationState appNotificationState,
    ListNotificationComplete action) {
  return appNotificationState
        // action.notifications is `List<Notification>`
      .addAll(action.notifications)
      .rebuild((b) => b..isLoading = false);
}
```

### To Add Many (appends to previous data)

```
AppNotificationState listNotificationComplete(
    AppNotificationState appNotificationState,
    ListNotificationComplete action) {
  return appNotificationState
        // action.notifications is `List<Notification>`
      .addMany(action.notifications)
      .rebuild((b) => b..isLoading = false);
}
```

### To Update One

```
AppNotificationState listNotificationComplete(
    AppNotificationState appNotificationState,
    ListNotificationComplete action) {
  return appNotificationState
        // action.notification is `Notification`
      .updateOne(action.notification)
      .rebuild((b) => b..isLoading = false);
}
```

### To Update Many

```
AppNotificationState listNotificationComplete(
    AppNotificationState appNotificationState,
    ListNotificationComplete action) {
  return appNotificationState
        // action.notifications is `List<Notification>`
      .updateMany(action.notifications)
      .rebuild((b) => b..isLoading = false);
}
```

### To Remove One

```
AppNotificationState listNotificationComplete(
    AppNotificationState appNotificationState,
    ListNotificationComplete action) {
  return appNotificationState
        // action.notification is `int`
      .removeOne(action.notificationId)
      .rebuild((b) => b..isLoading = false);
}
```

### To Remove Many

```
AppNotificationState listNotificationComplete(
    AppNotificationState appNotificationState,
    ListNotificationComplete action) {
  return appNotificationState
        // action.notifications is `List<Notification>`
      .removeMany(action.notifications)
      .rebuild((b) => b..isLoading = false);
}
```

### To Remove All

```
AppNotificationState listNotificationComplete(
    AppNotificationState appNotificationState,
    ListNotificationComplete action) {
  return appNotificationState
        // action.notifications is `List<Notification>`
      .removeAll()
      .rebuild((b) => b..isLoading = false);
}
```

### How to get the data

```
static _ViewModel fromStore(Store<AppState> store) {
       return _ViewModel(
           notifications: store.state.appNotification.getAll(),
           isLoading: store.state.appNotification.isLoading,
           notificationTapped: (AppNotification notification) {
             store.dispatch(UpdateNotification(notification: notification));
           });
     }
```

### How to get the sorted data
```
static _ViewModel fromStore(Store<AppState> store) {
       return _ViewModel(
           notifications: store.state.appNotification.getAll((notif1,notif2)=>notif1.id.compareTo(notif2.id),
           });
     }
```
