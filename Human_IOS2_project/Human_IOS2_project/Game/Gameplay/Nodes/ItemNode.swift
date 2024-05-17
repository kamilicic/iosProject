//
//  ItemNode.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 18.12.2023.
//

import SpriteKit

final class ItemNode1: SKSpriteNode {
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.Armory.sword)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        zPosition = Layer.player
        position.x = -size.width * 2.1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
final class ItemNode2: SKSpriteNode {
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.Armory.shield)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        zPosition = Layer.player
        position.x = -size.width * 1.05
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
final class ItemNode3: SKSpriteNode {
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.Armory.shield2)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        zPosition = Layer.player
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
final class ItemNode4: SKSpriteNode {
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.Armory.biggerSword)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        zPosition = Layer.player
        position.x = size.width * 1.05
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
final class ItemNode5: SKSpriteNode {
    init(){
        let texture = SKTexture(imageNamed: Assets.Textures.Materials.nail)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        zPosition = Layer.player
        position.x = size.width * 2.1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
