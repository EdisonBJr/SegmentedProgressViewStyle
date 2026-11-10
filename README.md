# SegmentedProgressViewStyle

A SwiftUI `ProgressViewStyle` that renders a `ProgressView` as a horizontal bar made of discrete, rounded segments. The unfilled track and the filled progress share the same dash pattern, so the bar reads as a row of segments that light up as the value advances.

## Requirements

- iOS 17.0+
- macOS 14.0+
- Xcode 15+ (Swift 5.9)

## Installation

Add the package via Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/aiaestheticsgit/SegmentedProgressViewStyle", from: "1.0.0")
],
```

Or in Xcode: **File → Add Package Dependencies…**, enter `https://github.com/aiaestheticsgit/SegmentedProgressViewStyle`, and add the `SegmentedProgressViewStyle` library to your app target.

Versions are published as git tags (`1.0.0`, `1.1.0`, …), so pin the range that fits your needs — e.g. `from: "1.0.0"`, `exact: "1.0.0"`, or `"1.0.0"..<"2.0.0"`.

Import it wherever you use the style:

```swift
import SegmentedProgressViewStyle
```

## Usage

Apply the style to any `ProgressView` that has a `value`:

```swift
ProgressView(value: 0.6)
    .progressViewStyle(.segmented)
```

The `.segmented` convenience is provided through a `ProgressViewStyle` extension, so it works with the standard `.progressViewStyle(_:)` modifier.

### Customizing

Every property has a sensible default, so override only what you need:

```swift
ProgressView(value: 0.6)
    .progressViewStyle(
        .segmented(
            segments: 8,
            trackColor: .gray.opacity(0.25),
            progressColor: .green,
            lineWidth: 4,
            gapLength: 6
        )
    )
```

You can also construct the style directly and pass the instance:

```swift
let style = SegmentedProgressViewStyle(segments: 8, lineWidth: 4)
ProgressView(value: 0.6)
    .progressViewStyle(style)
```

## Configuration

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `segments` | `Int` | `5` | Number of segments (dashes) across the full width of the bar. |
| `trackColor` | `Color` | `.secondary.opacity(0.5)` | Color of the unfilled track. |
| `progressColor` | `Color` | `.accentColor` | Color of the filled portion. |
| `lineWidth` | `CGFloat` | `5.0` | Stroke width of each segment, in points. |
| `gapLength` | `CGFloat` | `8.0` | Gap between adjacent segments, in points. |

## How it works

The style measures its available width with a `GeometryReader` and derives a dash pattern from `segments` and `gapLength`. It then draws two rounded, dashed horizontal lines in a leading-aligned `ZStack`:

1. The **track**, spanning the full width, in `trackColor`.
2. The **progress**, whose width is proportional to `configuration.fractionCompleted` (clamped to `0.0...1.0`), in `progressColor`.

Because both lines use the same dash pattern, the filled portion always aligns with the underlying segments.

## Testing

The package ships with a test target built on the [Swift Testing](https://developer.apple.com/documentation/testing) framework:

```bash
swift test
```

## License

Released under the MIT License — see [LICENSE](LICENSE).
