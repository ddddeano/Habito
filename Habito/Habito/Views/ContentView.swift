//
//  ContentView.swift
//  Habito
//
//  Created by Daniel Watson on 17/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State var isActive = false
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("HABITO")
                    .font(.largeTitle)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("empower through habit")
                    .font(.subheadline)
                Spacer()
                NavigationLink(destination: Create(), isActive: $isActive) {
                    Button(action: {
                        isActive = true
                    }) {
                        HStack {
                            Image(systemName: "power")
                            Text("Power Up")
                        }
                        .foregroundColor(.orange)
                    }
                }
                Spacer(minLength: 100)
            }.buttonStyle(PrimaryButtonStyle())
        }
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
