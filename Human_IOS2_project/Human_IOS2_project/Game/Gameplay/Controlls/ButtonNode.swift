//
//  AttackButtonNode.swift
//  Human_IOS2_project
//
//  Created by Mário Zahorjan on 20.12.2023.
//

import SpriteKit
import Foundation

final class ButtonNode: JKButtonNode{
    init(normalTexture: String, highlightedTexture: String, bgName: String){
        super.init(backgroundNamed: bgName)
        setBackgroundsForState(normal: normalTexture, highlighted: highlightedTexture, disabled: "")
        zPosition = Layer.button
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
