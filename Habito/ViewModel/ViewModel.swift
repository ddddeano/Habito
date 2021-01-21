//
//  ViewModel.swift
//  Habito
//
//  Created by Daniel Watson on 17/01/2021.
//
import SwiftUI
import Combine

typealias UserId = String

final class CreateChallengeViewModel :ObservableObject {
    
    @Published var exersizeDropdown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropdown = ChallengePartViewModel(type: .startAmount)
    @Published var increaseDropdown = ChallengePartViewModel(type: .increase)
    @Published var lengthDropdowon = ChallengePartViewModel(type: .length)
    
    @Published var error: HabitoError?
    @Published var isLoading = false
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellebels: [AnyCancellable] = []
    
    enum Action {
        case createChallenge
    }
    
    init(
        userService: UserServiceProtocol = UserService(),
        challengeService: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action: Action) {
        switch action {
        case .createChallenge:
            isLoading = true
            currentUserId().flatMap { userId -> AnyPublisher<Void, HabitoError> in
                return self.createChallenge(userId: userId)
            }.sink { completion in
                self.isLoading = false
                switch completion {
                case let .failure(error):
                    self.error = error
                case .finished:
                    print("Finished")
                }
            } receiveValue: { _ in
                print("success")
            }.store(in: &cancellebels)
        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, HabitoError> {
        guard   let exersize = exersizeDropdown.text,
                let startAmount = startAmountDropdown.number,
                let increase = increaseDropdown.number,
                let length = lengthDropdowon.number else {
            return Fail(error: .default(description: "Parsing Error")).eraseToAnyPublisher()
        }
        let challenge = Challenge(
            exersize: exersize,
            startAmount: startAmount,
            increase: increase,
            length: length,
            userId: userId,
            startDate: Date()
        )
        return challengeService.create(challenge).eraseToAnyPublisher()
    }
    
    private func currentUserId() -> AnyPublisher<UserId, HabitoError> {
        print("getting UserId")
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId, HabitoError> in
            return Fail(error: .auth(description: "someFirebase Auth Error")).eraseToAnyPublisher()
//            if let userId = user?.uid {
//                print("User is logged in....")
//                return Just(userId)
//                    .setFailureType(to: HabitoError.self)
//                    .eraseToAnyPublisher()
//            } else {
//                print("user is being loggecd in Anaonymously")
//                return self.userService
//                    .signInAnonymously()
//                    .map { $0.uid }
//                    .eraseToAnyPublisher()
//            }
        }.eraseToAnyPublisher()
    }
}

extension CreateChallengeViewModel {
    
    struct ChallengePartViewModel: DropdownItemProtocol {
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
        }
        
        var isSelected: Bool = false
        private let type: ChallengePartType
        
        init(type: ChallengePartType) {
            switch type {
            case .exercise:
                self.options = ExerciseOption.allCases.map { $0.toDropdownOption }
            case .startAmount:
                self.options = StartOption.allCases.map { $0.toDropdownOption }
            case .increase:
                self.options = IncreaseOption.allCases.map { $0.toDropdownOption }
            case .length:
                self.options = LengthOption.allCases.map { $0.toDropdownOption }
            }
            self.type = type
            self.selectedOption = options.first!
        }
        
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "challenge Length"
        }
        
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .text(rawValue),
                    formatted: rawValue.capitalized
                )
            }
        }
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatted: "\(rawValue)"
                )
            }
        }
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatted: "+\(rawValue)"
                )
            }
        }
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 12, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatted: "\(rawValue) days"
                )
            }
        }
    }
}

extension CreateChallengeViewModel.ChallengePartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}
