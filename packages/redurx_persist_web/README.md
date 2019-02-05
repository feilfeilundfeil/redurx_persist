# redurx_persist_web [![pub package](https://img.shields.io/pub/v/redurx_persist_web.svg)](https://pub.dartlang.org/packages/redurx_persist_web)

Web Storage Engine for [`redurx_persist`](https://pub.dartlang.org/packages/redurx_persist).

Saves to `localStorage`.

## Usage

```dart
final persistor = Persistor<AppState>(
  // ...
  storage: WebStorage(),
);
```

## Key

You can pass a key argument to `WebStorage` to set the key for `localStorage`.


## Features and bugs

Please file feature requests and bugs at the
[issue tracker](https://github.com/feilfeilundfeil/redurx_persist/issues).
