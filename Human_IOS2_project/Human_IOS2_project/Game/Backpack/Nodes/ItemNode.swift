//
//  ItemNode.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 08.01.2024.
//

import SpriteKit

final class ItemNode: SKSpriteNode, UIAccessibilityIdentification  {
    var accessibilityIdentifier: String?
    
    var type: String
    var index: Int
    init(texture: SKTexture, name: String, index: Int){
        self.type = "item"
        self.index = index
        super.init(texture: texture, color: .clear, size: CGSize(width: 35, height: 25))
        self.name = name
        
        zPosition = Layer.base
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
