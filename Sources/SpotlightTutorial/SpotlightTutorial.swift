// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct AbsoluteFrameInSpaceModifier: ViewModifier {
    let space: AnyHashable
    @Binding var rect: CGRect

    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { proxy in
                let r = proxy.frame(in: .named(space))
                Color.clear
                    .onAppear { rect = r }
                    .onChange(of: r) {
                        rect = $0
                    }
            }
            .allowsHitTesting(false)
        )
    }
}

extension View {
    public func getAbsoluteFrame(in space: AnyHashable, rect: Binding<CGRect>) -> some View {
        modifier(AbsoluteFrameInSpaceModifier(space: space, rect: rect))
    }
}

public struct Tutorial: Hashable {
    let spaceName: String = UUID().uuidString
    internal(set) public var rect: CGRect = .zero
    private(set) public var isSpotted = false
    let padding: CGFloat
    let cornerRadius: CGFloat
    let spotColor: Color
    let spotOpacity: CGFloat

    public mutating func fire() {
        self.isSpotted = true
    }

    public mutating func unFire() {
        self.isSpotted = false
    }

    public init(padding: CGFloat = 12, cornerRadius: CGFloat = 12, spotColor: Color = .black, spotOpacity: CGFloat = 0.5) {
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.spotColor = spotColor
        self.spotOpacity = spotOpacity
    }
}

extension View {

    @ViewBuilder
    public func tutorialSpot(tutorial: Binding<Tutorial>) -> some View {
        self.getAbsoluteFrame(in: tutorial.wrappedValue.spaceName, rect: tutorial.rect)
    }

    @ViewBuilder
    public func tutorialOverlay(tutorial: Tutorial) -> some View {
        if tutorial.isSpotted {
            self
                .coordinateSpace(name: tutorial.spaceName)
                .overlay {
                    ZStack {
                        tutorial.spotColor.opacity(tutorial.spotOpacity)
                        RoundedRectangle(cornerRadius: tutorial.cornerRadius, style: .continuous)
                            .frame(width: tutorial.rect.width + tutorial.padding, height: tutorial.rect.height + tutorial.padding)
                            .position(x: tutorial.rect.midX, y: tutorial.rect.midY)
                            .blendMode(.destinationOut)
                    }
                    .compositingGroup()
                    .allowsHitTesting(false)
                }
        } else {
            self
        }
    }
}
