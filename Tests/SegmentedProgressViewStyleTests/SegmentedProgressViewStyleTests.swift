import Testing
import SwiftUI
@testable import SegmentedProgressViewStyle

@Suite("SegmentedProgressViewStyle")
struct SegmentedProgressViewStyleTests {

    @Test("Default init uses expected values")
    func defaultInit() {
        let style = SegmentedProgressViewStyle()
        #expect(style.segments == 5)
        #expect(style.lineWidth == 5.0)
        #expect(style.gapLength == 8.0)
    }

    @Test("Custom init preserves values")
    func customInit() {
        let style = SegmentedProgressViewStyle(segments: 3, lineWidth: 2.0, gapLength: 4.0)
        #expect(style.segments == 3)
        #expect(style.lineWidth == 2.0)
        #expect(style.gapLength == 4.0)
    }

    @Test("Static segmented() returns configured style")
    func staticSegmented() {
        let style = SegmentedProgressViewStyle.segmented(segments: 4)
        #expect(style.segments == 4)
    }

    @Test("Static segmented var uses defaults")
    func staticSegmentedVar() {
        let style = SegmentedProgressViewStyle.segmented
        #expect(style.segments == 5)
    }
}
