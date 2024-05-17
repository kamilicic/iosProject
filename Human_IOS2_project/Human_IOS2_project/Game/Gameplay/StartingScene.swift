//
//  StartingScene.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 29.01.2024.
//

import SpriteKit
import GameplayKit

class StartingScene: SKScene{
    
    let playButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 100, height: 30))
    let playBtn: UIButton = UIButton(type: .system)
    
    let startLabel: SKLabelNode = SKLabelNode(text: "Human survival")
    
    var background: BackpackBackgroundNode!
    
    override init(size: CGSize) {
        super.init(size: CGSize(width: size.width / 2, height: size.height / 2))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        background = BackpackBackgroundNode(textureName: Assets.Textures.Background.start)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        
        startLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.65)
        startLabel.fontSize = 30
        startLabel.zPosition = Layer.button
        startLabel.fontColor = .white
        startLabel.fontName = "AvenirNext-Bold"
        
        playButton.position = CGPoint(x: size.width * 0.38, y: size.height * 0.22)
        playButton.zPosition = Layer.button
        playButton.fillColor = .systemGray4
        playButton.strokeColor = .black
        
        // Set up UIButton properties
            playBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 40) // Set the size
            playBtn.setTitle("Play", for: .normal) // Set the title
            playBtn.setTitleColor(.black, for: .normal) // Set the text color
        //playBtn.titleLabel?.font
            playBtn.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 36) // Set the font and size
        playBtn.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside) // Add a target action
        
        playBtn.accessibilityIdentifier = "play"
        playBtn.isAccessibilityElement = true
        
        // Center the UIButton inside the SKShapeNode
        let buttonCenter = CGPoint(x: size.width / 2 + playButton.frame.midX, y: playButton.frame.midY * 4.75)
        playBtn.center = buttonCenter
        
        // Add the SKShapeNode to the scene
        addChild(startLabel)
        addChild(playButton)
        
        // Add the UIButton as a subview to the SKView
        if let skView = self.view as? SKView {
            skView.addSubview(playBtn)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        if touchedNodes.contains(playButton) {
           // Handle touches on craftingButton
           playGame()
       }
    }

    
    @objc func playButtonTapped() {
        // Handle button tap
        playGame()
        print("Play button tapped!")
    }
    
    func playGame(){
        playButton.removeFromParent()
        playBtn.removeFromSuperview()
        startLabel.removeFromParent()
        background.removeFromParent()
        
        let animationTexture = SKTexture(imageNamed: Assets.Textures.Background.startAnimation1)
        let animatedBg = SKSpriteNode(texture: animationTexture, size: CGSize(width:  852 / 2, height: 393 / 2))
        
        animatedBg.zPosition = 10000
        animatedBg.position.x = size.width / 2
        animatedBg.position.y = size.height / 2
        
        let animatedBgAnimations =
    SKAction.sequence(
        [SKAction.fadeIn(withDuration: 0.2),
         SKAction.wait(forDuration: 3),
         SKAction.fadeOut(withDuration: 0.2),
         SKAction.customAction(withDuration: 0.3, actionBlock: {_,_ in
                animatedBg.texture = SKTexture(imageNamed: Assets.Textures.Background.startAnimation2)
                }),
         SKAction.fadeIn(withDuration: 0.2),
         SKAction.wait(forDuration: 3),
         SKAction.fadeOut(withDuration: 0.2),
          SKAction.customAction(withDuration: 0.3, actionBlock: {_,_ in
              animatedBg.texture = SKTexture(imageNamed: Assets.Textures.Background.startAnimation3)
                 }),
         SKAction.fadeIn(withDuration: 0.2),
         SKAction.wait(forDuration: 3),
         SKAction.customAction(withDuration: 1, actionBlock: {_,_ in
                 if let scene = GKScene(fileNamed: "GameScene") {
                     
                     // Get the SKScene from the loaded GKScene
                     if let sceneNode = scene.rootNode as! GameScene? {
                         
                         // Copy gameplay related content over to the scene
                         
                         // Set the scale mode to scale to fit the window
                         sceneNode.scaleMode = .aspectFill
                         // Present the scene
                         if let view = self.view {
                             view.presentScene(sceneNode)
                             //view.showsPhysics = true
                         }
                     }
                 }}),
             ])
        
        animatedBg.run(animatedBgAnimations)
        addChild(animatedBg)
        
    }
}
