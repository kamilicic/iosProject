//
//  BackgroundNode.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 18.12.2023.
//

import SpriteKit

final class BackgroundNode: SKSpriteNode {
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.Background.snowyWinter)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        zPosition = Layer.background
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
