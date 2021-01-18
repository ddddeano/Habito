//
//  Create.swift
//  Habito
//
//  Created by Daniel Watson on 17/01/2021.
//

import SwiftUI

struct Create: View {
    @StateObject var viewModel = CreateChallengeViewModel()
    @State var isActive = false
    
    var dropdownList: some View {
        ForEach(viewModel.dropdowns.indices, id: \.self ) { index in
            DropdownView(viewModel: $viewModel.dropdowns[index])
        }
    }
    
    var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Select"),
            buttons: viewModel.displayedOptions.indices.map { index in
                let option = viewModel.displayedOptions[index]
                return .default(
                    Text(option.formatted)) {
                        viewModel.send(action: .selectedOption(index: index))
                    }
            })
    }
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                NavigationLink(destination: Remind(), isActive: $isActive) {
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Next")
                            .font(.title)
                            .foregroundColor(.orange)
                    }
                }
            }
            .actionSheet(
                isPresented: Binding<Bool>(
                    get: {
                        viewModel.hasSelectedDropdown
                    }, set: { _ in })
            ) {
                actionSheet
            }
            .padding()
            .navigationTitle("Form a habit")
        }
    }
}


struct Remind : View {
    @State var isActive = false
    
    var body: some View {
        VStack {
            //            DropdownView()
            Spacer()
            NavigationLink(destination: Remind(), isActive: $isActive) {
                Button(action: {
                    isActive = true
                }) {
                    Text("Next")
                        .foregroundColor(.orange)
                }
                .buttonStyle(PrimaryButtonStyle())
            }
        }
    }
}
//struct Create_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            VStack {
//            Remind()
//            Create()
//            }
//        }
//    }
//}
