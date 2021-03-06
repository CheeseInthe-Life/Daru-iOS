//
//  DaruStep.swift
//  Daru
//
//  Created by 재영신 on 2022/05/16.
//

import Foundation
import RxFlow

enum DaruStep: Step {
    
    // MainTabbar
    case mainIsRequired
    
    //Home
    case homeIsRequired
    case nearTeahouseIsRequired
    case recommendTeahouseIsRequired
    case teahouseDetailIsRequred
    
    //SignUp
    case signUpIsRequired(providerType: ProviderType, accessToken: String)
    case inputInfoIsRequired(providerType: ProviderType, accessToken: String)
    
    //MyDaru
    case myPageIsRequired
    case mbteaiIsRequired
    case favoriteTeaHouseRequired
    
    //Community
    case communityIsRequired
    case postListIsRequired
    case managePostIsRequired
    case postDetailIsRequired
    
    //teahouseMap
    case teahouseMapIsRequired
    
    //Setting
    case settingIsRequired
    
    //Alert
    case settingAlertIsRequired
}
