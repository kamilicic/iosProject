//
//  Physics.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 19.12.2023.
//

import Foundation

enum Physics{
    
}

extension Physics {
    enum CategoryBitMask {
        static let base: UInt32 = 0b1
        static let player: UInt32 = 0b10
        static let gameObject: UInt32 = 0
    }
}

extension Physics {
    enum CollisionBitMask {
        static let base = Physics.CategoryBitMask.player
        static let player = Physics.CategoryBitMask.base
    }
}

extension Physics {
    enum ContactTestBitMask {
        static let base = Physics.CategoryBitMask.player
        static let player = Physics.CategoryBitMask.gameObject
        static let gameObject = Physics.CategoryBitMask.player
    }
}
