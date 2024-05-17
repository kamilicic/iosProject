//
//  StatsNode.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 08.01.2024.
//

import SpriteKit

final class StatsNode: SKSpriteNode {
    var rectangle: SKSpriteNode!
    var rectangleBg: SKSpriteNode!
    init(texture: SKTexture, color: UIColor) {
        
        rectangle = SKSpriteNode(color: color, size: CGSize(width: 150, height: 20))
        rectangleBg = SKSpriteNode(color: .lightGray, size: CGSize(width: 150, height: 20))
        
        super.init(texture: texture, color: .clear, size: CGSize(width: 40, height: 20))
        
        rectangleBg.position.x = 100
        
        addChild(rectangleBg)
        betterStats()
        addChild(rectangle)
        zPosition = Layer.score
        rectangleBg.zPosition = Layer.score
        rectangle.zPosition = Layer.score
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func statMinus(howMuch: CGFloat){
        if (rectangle.size.width > 0){
            rectangle.size.width -= (15 * howMuch)
            rectangle.position.x -= (7.5 * howMuch)
        }
    }
    
    func statPlus(howMuch: CGFloat){
        if (howMuch == 2){
            if (rectangle.size.width < (150-15)){
                rectangle.size.width += (15 * howMuch)
                rectangle.position.x += (7.5 * howMuch)
            } else if (rectangle.size.width >= (150-15) && rectangle.size.width < 150){
                rectangle.size.width += (15)
                rectangle.position.x += (7.5)
            }
        } else if (howMuch == 3){
            if (rectangle.size.width < (150-30)){
                rectangle.size.width += (15 * howMuch)
                rectangle.position.x += (7.5 * howMuch)
            } else if (rectangle.size.width < (150-15)){
                rectangle.size.width += (15 * (howMuch - 1))
                rectangle.position.x += (7.5 * (howMuch - 1))
            } else if (rectangle.size.width >= (150-15) && rectangle.size.width < 150){
                    rectangle.size.width += (15)
                    rectangle.position.x += (7.5)
            }
        }
    }
    
    func restoreStat(){
        rectangle.size.width = 150
        rectangle.position.x = 100
    }
    
    func betterStats() {
        for i in 0...8 {
            let rect = SKSpriteNode(color: .black, size: CGSize(width: 0.75, height: 20))
            rect.position.x = 41 + (15 * CGFloat(i))
            rect.zPosition = Layer.score + 1
            addChild(rect)
        }
    }
}
