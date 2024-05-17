//
//  Sadn].swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 19.12.2023.
//

import SpriteKit

final class SandBaseNode: SKSpriteNode {
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.Base.sandBase)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        zPosition = Layer.base
        
        position.y = -size.height * 2.4//7
        position.x = -size.width * 0.57
        
        physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x: 0, y: -size.height * 0.011))
        
        physicsBody?.categoryBitMask = Physics.CategoryBitMask.base
        physicsBody?.collisionBitMask = Physics.CollisionBitMask.base
        
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
