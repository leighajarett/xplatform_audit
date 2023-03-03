// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import SwiftUI

/// The SwiftUI view that appears as an overlay to our Flutter.
struct OverlaySwiftUIView: View {
    @ObservedObject var controller: OverlayFlutterViewController
    @State var text: String = ""
    @State var selectedText: String = ""
    @State var toggle = false
    
    //    var body: some View {Text("This is SwiftUI")}
    var controlDictionary: [String: AnyView] = [
        "Top App Bar": AnyView(TopAppBar()),
        "Bottom Tab Bar": AnyView(TabBar()),
        "Alert Dialog": AnyView(AlertDialog()),
    ]
    
//    @ViewBuilder
    var body: some View {
        if controller.controlKey != nil  && controlDictionary.keys.contains(controller.controlKey!) {
            controlDictionary[controller.controlKey!]
        } else {
            Text("Nothing Selected")
        }
    }
}

struct TopAppBar: View {
    @State var largeTitle = false
    
    var body: some View {
        
        NavigationStack {
                    NavigationLink("Navigate", value: "AppCircle").navigationTitle("Material App Bar").navigationBarTitleDisplayMode(.large)
                        .navigationDestination(for: String.self) { value in
                            HStack{
                                Text("Inline title").navigationTitle("Material App Bar").navigationBarTitleDisplayMode(largeTitle ? .large : .inline)
                                Button("Change title") {
                                    largeTitle = !largeTitle
                                }}
                            
                    }
        }

    }
}

struct TabBar :  View {
    var body: some View {
        TabView {
            Text("Menu")
                .tabItem {
                    Label("Menu", systemImage: "house")
                }

            Text("Order")
                .tabItem {
                    Label("Order", systemImage: "square.and.arrow.up")
                }
        }
    }
}

struct AlertDialog: View {
    var body: some View {
        Text("Alert Dialog")
    }
}
