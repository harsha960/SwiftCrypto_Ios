//
//  HapticManager.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 17/08/23.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    static func notifications(type:  UINotificationFeedbackGenerator.FeedbackType)
    {
        generator.notificationOccurred(type)
    }
}
