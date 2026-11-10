import SwiftUI

/// A `ProgressViewStyle` that renders a `ProgressView` as a horizontal bar of discrete, rounded segments.
///
/// The unfilled track and the filled progress share the same dash pattern, so the bar reads as a row of
/// segments that light up as the value advances. Apply it with `.progressViewStyle(.segmented)`.
public struct SegmentedProgressViewStyle: ProgressViewStyle {

    @Animatable struct HorizontalLine: Shape {

        var length: CGFloat

        func path(in rect: CGRect) -> Path {

            var path = Path()

            path.move(to: CGPoint(x: 0.0, y: rect.midY))
            path.addLine(to: CGPoint(x: min(length, rect.width), y: rect.midY))

            return path
        }
    }

    /// The number of segments (dashes) laid out across the full width of the bar.
    public let segments: Int
    /// The color of the unfilled track.
    public var trackColor: Color
    /// The color of the filled portion of the bar.
    public var progressColor: Color
    /// The stroke width of each segment, in points.
    public var lineWidth: CGFloat
    /// The gap between adjacent segments, in points.
    public var gapLength: CGFloat

    /// Creates a segmented progress view style.
    ///
    /// - Parameters:
    ///   - segments: The number of segments across the bar. Defaults to `5`.
    ///   - trackColor: The color of the unfilled track. Defaults to `.secondary` at 50% opacity.
    ///   - progressColor: The color of the filled portion. Defaults to `.accentColor`.
    ///   - lineWidth: The stroke width of each segment, in points. Defaults to `5.0`.
    ///   - gapLength: The gap between adjacent segments, in points. Defaults to `8.0`.
    public init(segments: Int = 5, trackColor: Color = .secondary.opacity(0.5), progressColor: Color = .accentColor, lineWidth: CGFloat = 5.0, gapLength: CGFloat = 8.0) {
        self.segments = segments
        self.trackColor = trackColor
        self.progressColor = progressColor
        self.lineWidth = lineWidth
        self.gapLength = gapLength
    }

    /// Renders the track and the progress as two rounded, dashed lines in a leading-aligned `ZStack`.
    public func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in

            let dashes = max(2.0, CGFloat(segments))
            let dashLength = max(0.0, (geometry.size.width / dashes) - gapLength)
            let trackLength = max(0.0, geometry.size.width - gapLength)
            let progressLength = max(0.0, (geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0.0)) - gapLength)
            let dashed = StrokeStyle(lineWidth: lineWidth, lineCap: .round, dash: [dashLength, gapLength])

            ZStack(alignment: .leading) {
                HorizontalLine(length: trackLength)
                    .stroke(style: dashed)
                    .foregroundStyle(trackColor)

                HorizontalLine(length: progressLength)
                    .stroke(style: dashed)
                    .foregroundStyle(progressColor)
            }
        }
    }
}

extension ProgressViewStyle where Self == SegmentedProgressViewStyle {

    /// Returns a segmented progress view style configured with the given values.
    ///
    /// - Parameters:
    ///   - segments: The number of segments across the bar. Defaults to `5`.
    ///   - trackColor: The color of the unfilled track. Defaults to `.secondary` at 50% opacity.
    ///   - progressColor: The color of the filled portion. Defaults to `.accentColor`.
    ///   - lineWidth: The stroke width of each segment, in points. Defaults to `5.0`.
    ///   - gapLength: The gap between adjacent segments, in points. Defaults to `8.0`.
    public static func segmented(segments: Int = 5, trackColor: Color = .secondary.opacity(0.5), progressColor: Color = .accentColor, lineWidth: CGFloat = 5.0, gapLength: CGFloat = 8.0) -> SegmentedProgressViewStyle {
        SegmentedProgressViewStyle(segments: segments, trackColor: trackColor, progressColor: progressColor, lineWidth: lineWidth, gapLength: gapLength)
    }

    /// A segmented progress view style using all default values.
    public static var segmented: SegmentedProgressViewStyle {
        .segmented()
    }
}

#Preview {
    ProgressView(value: 0.6)
        .progressViewStyle(.segmented)
}
