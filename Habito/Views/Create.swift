//
//  Create.swift
//  Habito
//
//  Created by Daniel Watson on 17/01/2021.
//

import SwiftUI

struct Create: View {
    @StateObject var viewModel = CreateChallengeViewModel()
    
    var dropdownList: some View {
        Group {
            DropdownView(viewModel: $viewModel.exersizeDropdown)
            DropdownView(viewModel: $viewModel.startAmountDropdown)
            DropdownView(viewModel: $viewModel.increaseDropdown)
            DropdownView(viewModel: $viewModel.lengthDropdowon)
        }
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                Button(action: {
                    viewModel.send(action: .createChallenge)
                }) {
                    Text("Create")
                        .font(.title)
                        .foregroundColor(.orange)
                }
            }
        }
    }
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                mainContentView
            }
        }.alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
            Alert(
                title: Text("Error "),
                message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""),
                dismissButton: .default(Text("OK"), action: {
                    viewModel.error = nil
                })
            )
        }
        .navigationBarTitle("Form a habit")
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, 15)
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
