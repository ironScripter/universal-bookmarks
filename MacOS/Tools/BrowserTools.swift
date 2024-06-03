//
//  Browsers.swift
//  Simple Universal Bookmarks
//
//  Created by James Arnett on 5/24/24.
//

import Foundation
import Cocoa
import SwiftData

func getInstalledBrowsers() -> [Browser] {
    let browserBundleIdentifiers = [
        "com.apple.Safari",
        "com.google.Chrome",
        "org.mozilla.firefox",
        "com.microsoft.edgemac",
        "com.brave.browser"
        // Add more browser bundle identifiers as needed
    ]
    
    var installedBrowsers: [Browser] = []
    
    for bundleIdentifier in browserBundleIdentifiers {
        if let appURL = LSCopyApplicationURLsForBundleIdentifier(bundleIdentifier as CFString, nil)?.takeRetainedValue() {
            if let appPath = (appURL as NSArray).firstObject as? URL {
                installedBrowsers.append(
                    Browser(
                        name: appPath.lastPathComponent.replacingOccurrences(of: ".app", with: ""),
                        url: appPath.absoluteURL
                    )
                )
            }
        }
    }
    return installedBrowsers
}

//func openURLInBrowser(url: String, browser: URL) {
//    if let safariURL = URL(string: url) {
//        NSWorkspace.shared.open([safariURL], withApplicationAt: browser, configuration: NSWorkspace.OpenConfiguration() )
//    }
//}

func openURLInBrowser(url: String, browser: URL, completion: @escaping () -> Void) {
    if let browserFileURL = URL(string: url) {
        NSWorkspace.shared.open([browserFileURL], withApplicationAt: browser, configuration: NSWorkspace.OpenConfiguration())
        checkIfAppIsActive(bundleIdentifier: getBundleIdentifier(from: browser), completion: completion)
    }
}

func getBundleIdentifier(from appURL: URL) -> String? {
    if let bundle = Bundle(url: appURL) {
        return bundle.bundleIdentifier
    }
    return nil
}

func checkIfAppIsActive(bundleIdentifier: String?, completion: @escaping () -> Void) {
    guard let bundleIdentifier = bundleIdentifier else {
        completion()
        return
    }
    
    DispatchQueue.global().async {
        while true {
            if NSRunningApplication.runningApplications(withBundleIdentifier: bundleIdentifier).first?.isActive == true {
                DispatchQueue.main.async {
                    completion()
                }
                break
            }
            Thread.sleep(forTimeInterval: 0.5) // Polling interval
        }
    }
}
