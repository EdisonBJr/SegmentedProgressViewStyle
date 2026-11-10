//
//  SegmentedProgressViewStyleAppApp.swift
//  SegmentedProgressViewStyleApp
//
//  Created by Edison Bezerra Junior on 10/11/26.
//

import SwiftUI
import SegmentedProgressViewStyle

@main
struct SegmentedProgressViewStyleAppApp: App {
    var body: some Scene {
        WindowGroup {
            ProgressView(value: 0.6)
                .progressViewStyle(.segmented)
                .padding()
        }
    }
}
