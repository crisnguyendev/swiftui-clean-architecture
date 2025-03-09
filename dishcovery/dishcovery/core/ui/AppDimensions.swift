//
//  AppDimensions.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/6/25.
//

import Foundation

struct AppDimensions {
    
    private init() {
        
    }
    
    struct Image {
        private init() {
            
        }
        struct Size {
            private init() {
                
            }
            static let small: CGFloat = 48
            static let medium: CGFloat = 96
            static let large: CGFloat = 192
        }
        static let cornerRadius: CGFloat = 16
    }
    
    struct Spacing {
        private init() {
            
        }
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }
}
