//
//  WaterBaseNode.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 19.12.2023.
//

import SpriteKit

final class WaterBaseNode: SKSpriteNode {
    init(){
        let textureAtlas = SKTextureAtlas(named: Assets.Textures.Base.waterBase)
        let textures = textureAtlas.textureNames.sorted().map{
            textureAtlas.textureNamed($0)
        }
        
        super.init(texture: textures.first, color: .clear, size: textures.first?.size() ?? .zero)
        
        run(
            .repeatForever(.animate(with: textures, timePerFrame: 0.4, resize: false, restore: true))
        )
        
        zPosition = Layer.base
        
        position.y = -size.height * 2.4
        position.x = -size.width * 1.5
        
        physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x: 0, y: -size.height))
        
        physicsBody?.categoryBitMask = Physics.CategoryBitMask.base
        physicsBody?.collisionBitMask = Physics.CollisionBitMask.base
        
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
