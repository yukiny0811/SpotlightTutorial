//
//  ContentView.swift
//  Demo
//
//  Created by Yuki Kuwashima on 2025/02/14.
//

import SwiftUI
import SpotlightTutorial

struct ContentView: View {

    @State var tutorial = Tutorial()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("tst") {
                print("testst")
            }

            Text("Hello, world!")
                .tutorialSpot(tutorial: $tutorial)

        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .tutorialOverlay(tutorial: tutorial)
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                tutorial.fire()
            }
        }
    }
}

#Preview {
    ContentView()
}
