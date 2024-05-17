//
//  FinalScreen.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 29.01.2024.
//

import SpriteKit
import GameplayKit

class FinalScene: SKScene{
    let mainMenuButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 100, height: 30))
    
    let congratulationLabel: SKLabelNode = SKLabelNode(text: "Congratulations")
    
    let mainMenuLabel: SKLabelNode = SKLabelNode(text: "Main menu")
    
    override init(size: CGSize) {
        super.init(size: CGSize(width: size.width / 2, height: size.height / 2))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        let background = BackpackBackgroundNode(
            textureName: Assets.Textures.Background.final
        )
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        congratulationLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.7)
        congratulationLabel.fontSize = 36
        congratulationLabel.zPosition = Layer.button
        congratulationLabel.fontColor = .white
        congratulationLabel.fontName = "AvenirNext-Bold"
        
        mainMenuButton.position = CGPoint(x: size.width * 0.6, y: size.height * 0.2)
        mainMenuButton.zPosition = Layer.button
        mainMenuButton.fillColor = .systemGray4
        mainMenuButton.strokeColor = .black
        
        mainMenuLabel.fontSize = 18
        mainMenuLabel.zPosition = Layer.button
        mainMenuLabel.fontColor = .black
        mainMenuLabel.fontName = "AvenirNext-Bold"
        mainMenuLabel.position = CGPoint(x: size.width * 0.7175, y: size.height * 0.235)
        
        addChild(congratulationLabel)
        addChild(mainMenuButton)
        addChild(mainMenuLabel)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        if touchedNodes.contains(mainMenuButton) {
           // Handle touches on craftingButton
            goToMainMenu()
       }
    }
    
    func goToMainMenu(){
        mainMenuButton.removeFromParent()
        mainMenuLabel.removeFromParent()
        
        let startingScene = StartingScene(size: CGSize(width: 852, height: 393))
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(startingScene, transition: transition)
    }
}
