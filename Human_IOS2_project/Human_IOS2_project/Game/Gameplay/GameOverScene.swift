//
//  GameOverScene.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 29.01.2024.
//

import SpriteKit
import GameplayKit

class GameOverScene: SKScene{
    let mainMenuButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 100, height: 30))
    let mainMenuLabel: SKLabelNode = SKLabelNode(text: "Main menu")
    
    
    let gameOverLabel: SKLabelNode = SKLabelNode(text: "Game over")
    
    let playAgainButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 100, height: 30))
    let playAgainLabel: SKLabelNode = SKLabelNode(text: "Play again")
    
    override init(size: CGSize) {
        super.init(size: CGSize(width: size.width / 2, height: size.height / 2))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        let background = BackpackBackgroundNode(
            textureName: Assets.Textures.Background.gameOver
        )
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        gameOverLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.65)
        gameOverLabel.fontSize = 36
        gameOverLabel.zPosition = Layer.button
        gameOverLabel.fontColor = .black
        gameOverLabel.fontName = "AvenirNext-Bold"
        
        playAgainButton.position = CGPoint(x: size.width * 0.385, y: size.height * 0.35)
        playAgainButton.zPosition = Layer.button
        playAgainButton.fillColor = .systemGray4
        playAgainButton.strokeColor = .black
        
        playAgainLabel.fontSize = 18
        playAgainLabel.zPosition = Layer.button
        playAgainLabel.fontColor = .black
        playAgainLabel.fontName = "AvenirNext-Bold"
        playAgainLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.385)
        
        addChild(gameOverLabel)
        addChild(playAgainButton)
        addChild(playAgainLabel)
        
        
        mainMenuButton.position = CGPoint(x: size.width * 0.385, y: size.height * 0.15)
        mainMenuButton.zPosition = Layer.button
        mainMenuButton.fillColor = .systemGray4
        mainMenuButton.strokeColor = .black
        
        mainMenuLabel.fontSize = 18
        mainMenuLabel.zPosition = Layer.button
        mainMenuLabel.fontColor = .black
        mainMenuLabel.fontName = "AvenirNext-Bold"
        mainMenuLabel.position = CGPoint(x: size.width * 0.5025, y: size.height * 0.185)
        
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
        if touchedNodes.contains(playAgainButton) {
           // Handle touches on craftingButton
            playAgain()
       }
    }
    
    func goToMainMenu(){
        self.removeAllChildren()
        
        let startingScene = StartingScene(size: CGSize(width: 852, height: 393))
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(startingScene, transition: transition)
    }
    
    func playAgain(){
        self.removeAllChildren()
        
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                // Present the scene
                if let view = self.view {
                    view.presentScene(sceneNode)
                    view.showsPhysics = true
                }
            }
        }
    }
}
