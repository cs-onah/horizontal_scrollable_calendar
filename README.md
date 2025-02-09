# horizontal_scrollable_calendar 

A bespoke user interface for picking date.

<img width="280" height="567" src="https://github.com/cs-onah/horizontal_scrollable_calendar/blob/main/docs/image.png">
<img width="280" height="567" src="https://github.com/cs-onah/horizontal_scrollable_calendar/blob/main/docs/anim.gif">

## Getting Started

Import the package as a git dependency. 

```yaml
horizontal_scrollable_calendar:
git:
  url: https://github.com/cs-onah/horizontal_scrollable_calendar
  ref: main
```

## Example

See sample code below

```dart
import 'package:flutter/material.dart';
import 'package:horizontal_scrollable_calendar/horizontal_scrollable_calendar.dart';

HorizontalScrollableCalendar(
  onSelect: (DateTime time) => debugPrint(time.toIso8601String()),
),
```
