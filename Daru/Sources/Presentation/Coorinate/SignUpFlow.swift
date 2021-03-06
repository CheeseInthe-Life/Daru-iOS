//
//  SignUpFlow.swift
//  Daru
//
//  Created by 재영신 on 2022/06/17.
//

import UIKit
import RxFlow

final class SignUpFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DaruStep else { return .none }
        
        switch step {
        case let .signUpIsRequired(providerType, accessToken):
            return navigateToAgreeTermsScene(providerType: providerType, accessToken: accessToken)
        case let .inputInfoIsRequired(providerType, accessToken):
            return navigateToInputInfoScene(providerType: providerType, accessToken: accessToken)
        default:
            return .none
        }
    }
}

private extension SignUpFlow {
    
    func navigateToAgreeTermsScene(providerType: ProviderType, accessToken: String) -> FlowContributors {
        let agreeTermsReactor = AgreeTermsReactor(providerType: providerType, accessToken: accessToken)
        let agreeTermsVC = AgreeTermsViewController(reactor: agreeTermsReactor)
        
        rootViewController.pushViewController(agreeTermsVC, animated: true)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: agreeTermsVC,
                withNextStepper: agreeTermsReactor
            )
        )
    }
    
    func navigateToInputInfoScene(providerType: ProviderType, accessToken: String) -> FlowContributors {
        let inputInfoReactor = InputInfoReactor(
            authService: AuthService(authNetworking: AuthNetworking()),
            keyChainService: KeyChainService(),
            providerType: providerType,
            accessToken: accessToken
        )
        let inputInfoVC = InputInfoViewController(reactor: inputInfoReactor)
        
        rootViewController.pushViewController(inputInfoVC, animated: true)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: inputInfoVC,
                withNextStepper: inputInfoReactor
            )
        )
    }
}
