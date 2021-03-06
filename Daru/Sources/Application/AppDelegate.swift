//
//  AppDelegate.swift
//  Daru
//
//  Created by 재영신 on 2022/04/20.
//

import UIKit
import KakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        KakaoSDK.initSDK(appKey: "b0c91845eadc1e726a1f5f7c44d2ef2d")
        
        setGlobalNavigationBar()
        
        return true
    }

}

private extension AppDelegate {
    func setGlobalNavigationBar() {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        barAppearance.setBackIndicatorImage(Constant.backIcon, transitionMaskImage: Constant.backIcon)
        UINavigationBar.appearance().scrollEdgeAppearance = barAppearance
        UINavigationBar.appearance().compactAppearance = barAppearance
        UINavigationBar.appearance().standardAppearance = barAppearance
    }
}
