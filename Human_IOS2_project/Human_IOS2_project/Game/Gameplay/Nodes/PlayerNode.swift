//
//  PlayerNode.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 18.12.2023.
//

import SpriteKit

final class PlayerNode: SKSpriteNode {
    let rectangle = SKSpriteNode()
    var lookingRight: Bool!
    
    //inventar polozky
    var storedItems: [Int]
    
    init(xpos: CGFloat, lRight: Bool){
        lookingRight = lRight
        
        // mozna to jde udelat lip, ale takto to funguje
        // melo by seto udelat i s animacemi, ale to nevim jak/nefunguje mi to
        let textureAtlasRight = SKTextureAtlas(named: Assets.Textures.Player.playerStandRight)
        let textureAtlasLeft = SKTextureAtlas(named: Assets.Textures.Player.playerStandLeft)
        var textures = textureAtlasRight.textureNames.sorted().map{
            textureAtlasRight.textureNamed($0)
        }
        if (lookingRight) {
            textures = textureAtlasRight.textureNames.sorted().map{
                textureAtlasRight.textureNamed($0)
            }
        } else {
            textures = textureAtlasLeft.textureNames.sorted().map{
                textureAtlasLeft.textureNamed($0)
            }
        }
        
        //inventar - takto to bude poskladane, aby se potom pres index zapisovalo do inventare/uloziste playera
        //storedItems = ["wood","stone","leaf","metal","coconut","woodPlank","sapling","bed","bucket","water bucket", "woodPickaxe","woodAxe","woodShovel","stonePickaxe","stoneAxe","stoneShovel","ironPickaxe","ironAxe","ironShovel","Better Mine", "Boat", "nail", "mine"]
        //storedItems = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        storedItems = [200, 200, 200, 200, 200, 200, 200, 0, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0]
        super.init(texture: textures.first, color: .clear, size: textures.first?.size() ?? .zero)
        
        
        /*run(
            .repeatForever(.animate(with: textures, timePerFrame: 0.2, resize: false, restore: true))
        )*/
        
        // POZICE HRACE
        zPosition = Layer.player
        position.y = -size.height * 1.35
        position.x = xpos
        
        rectangle.size = CGSize(width: size.width * 1.3, height: size.height)
        
        if (lookingRight) {
            self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rectangle.size.width, height: rectangle.size.height), center: CGPoint(x: size.width * 0.15, y: 0))
        } else {
            self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rectangle.size.width, height: rectangle.size.height), center: CGPoint(x: -size.width * 0.15, y: 0))
        }
        self.physicsBody?.categoryBitMask = Physics.CategoryBitMask.player
        self.physicsBody?.collisionBitMask = Physics.CollisionBitMask.player
        self.physicsBody?.contactTestBitMask = Physics.ContactTestBitMask.player
        
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.isDynamic = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func uploadStore(store: [Int]){
        for index in 0...(storedItems.count - 1) {
            storedItems[index] = store[index]
        }
    }
    
    func storeItem(item: Int){
        storedItems[item] += 1
    }
}
