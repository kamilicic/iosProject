//
//  BackpackBackground.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 19.12.2023.
//

import SpriteKit

final class BackpackBackgroundNode: SKSpriteNode {
    init(textureName: String){
        let texture = SKTexture(imageNamed: textureName)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        zPosition = Layer.background
        size.width = size.width * 0.47
        size.height = size.height * 0.47
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
