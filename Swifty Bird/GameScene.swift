//
//  GameScene.swift
//  Test Game
//
//  Created by Griffin Ledingham on 2014-06-03.
//  Copyright (c) 2014 Griffin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player = SKSpriteNode()
    var groundArr = SKSpriteNode[]()
    var skyArr = SKSpriteNode[]()
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake( 0.0, -5.0 )
        self.backgroundColor = SKColor(red: 78/255, green: 192/255, blue: 202/255, alpha: 1)
        
        var ground = SKSpriteNode()
        ground = SKSpriteNode(imageNamed:"ground")
        ground.xScale = 2
        ground.yScale = 2
        ground.position = CGPoint(x:440,y:100)
        groundArr.append(ground)
        self.addChild(ground)

        var background = SKSpriteNode()
        background = SKSpriteNode(imageNamed:"bg")
        background.xScale = 3
        background.yScale = 3
        background.position = CGPoint(x:400,y:370)
        skyArr.append(background)
        self.addChild(background)
        
        player = SKSpriteNode(imageNamed:"bird")
        player.xScale = 2
        player.yScale = 2
        player.position = CGPoint(x:337.0,y:641.0)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.height / 2.0)
        player.physicsBody.dynamic = true
        player.physicsBody.allowsRotation = false
        self.addChild(player)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            player.physicsBody.velocity = CGVectorMake(0,0)
            player.physicsBody.applyImpulse(CGVectorMake(0, 35))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        playerRotate()
        playerDie()
        
        moveGround()
        moveSky()
        
        addGround()
        addSky()
        
        cleanGround()
        cleanSky()
    }
    
    func playerRotate() {
        player.zRotation = player.physicsBody.velocity.dy/300
        
        if((player.zRotation) < -1.3) {
            player.zRotation = -1.3
        }
    }
    
    func playerDie() {
        if(player.position.y < 0) {
            player.position = CGPoint(x:337,y:641)
            player.physicsBody.velocity = CGVectorMake(0, 0)
        }
    }
    
    func moveGround() {
        for(var i = 0;i<groundArr.count;i++) {
            groundArr[i].position.x -= 5
        }
    }
    
    func moveSky() {
        for(var i = 0;i<skyArr.count;i++) {
            skyArr[i].position.x -= 0.5
        }
    }
    
    func addGround() {
        if(groundArr[groundArr.count-1].position.x - groundArr[groundArr.count-1].size.width/2 - 200 < 0) {
            var ground = SKSpriteNode()
            ground = SKSpriteNode(imageNamed:"ground")
            ground.xScale = 2
            ground.yScale = 2
            ground.position = CGPoint(x:groundArr[groundArr.count-1].position.x + groundArr[groundArr.count-1].size.width,y:100)
            groundArr.append(ground)
            self.addChild(ground)
        }
    }
    
    func addSky() {
        if(skyArr[skyArr.count-1].position.x - skyArr[skyArr.count-1].size.width/2 < 0) {
            var background = SKSpriteNode(imageNamed:"bg")
            background.xScale = 3
            background.yScale = 3
            background.position = CGPoint(x:skyArr[skyArr.count-1].position.x + skyArr[skyArr.count-1].size.width,y:370)
            skyArr.append(background)
            self.addChild(background)
        }
    }
    
    func cleanGround() {
        var groundToRemove = Int[]()
        
        for(var i = 0;i<groundArr.count;i++) {
            if(groundArr[i].position.x + groundArr[i].size.width/2 < 0) {
                groundToRemove.append(i)
            }
        }
        
        for(var i = groundToRemove.count-1;i > -1;i--) {
            groundArr.removeAtIndex(groundToRemove[i])
        }
        
        for(var i = 0;i<skyArr.count;i++) {
            skyArr[i].position.x -= 0.5
        }
    }

    func cleanSky() {
        var skyToRemove = Int[]()
        
        for(var i = 0;i<skyArr.count;i++) {
            if(skyArr[i].position.x + skyArr[i].size.width/2 < 0) {
                skyToRemove.append(i)
            }
        }
        
        for(var i = skyToRemove.count-1;i > -1;i--) {
            skyArr.removeAtIndex(skyToRemove[i])
        }
    }
}
