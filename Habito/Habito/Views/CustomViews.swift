//
//  CustomViews.swift
//  Habito
//
//  Created by Daniel Watson on 17/01/2021.
//

import SwiftUI
import Foundation

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return PrimaryButton(config: configuration)
    }
    struct PrimaryButton: View {
        let config: Configuration
        var body: some View {
            return config.label
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2))
                .foregroundColor(.black)
        }
    }
}

struct DropdownView<T: DropdownItemProtocol> : View {
    @Binding var viewModel: T
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.headerTitle)
                    .font(.system(size: 22, weight: .semibold ))
                    .padding(.leading, 5)
                Spacer()
            }
            .padding(.top, 20)
            Button(action: {
                viewModel.isSelected = true
            }) {
                HStack {
                    Text(viewModel.dropdownTitle)
                    Spacer()
                    Image(systemName: "chevron.down.circle")
                }
                .font(.system(size: 28, weight: .semibold ))
                .foregroundColor(.orange)
            }.buttonStyle(PrimaryButtonStyle())
        }
        .padding()
    }
}

//struct CustomViews_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            Button(action: {}) {
//                Text("Create")
//                    .foregroundColor(.orange)
//            }.buttonStyle(PrimaryButtonStyle())
//            DropdownView()
//        }
//    }
//}
