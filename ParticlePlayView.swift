//
//  SnowView.swift
//  GLCommonComponent
//
//  Created by Gyu on 2022/11/22.
//

import UIKit

public class ParticlePlayView: UIView {

    private var skView: SKView?
    private var glskScene: GLSKScene?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**sksFileName = Sprite Kit Particle file Name*/
    open func start(sksFileName: String, particleSize: CGSize = CGSize(width: 50, height: 50)) {
        stop()
        skView = SKView()
        skView!.backgroundColor = .clear
        glskScene = GLSKScene()
        skView!.presentScene(glskScene)
        self.addSubview(skView!)
        skView!.snp.makeConstraints { make in
            make.left.top.equalTo(0)
            make.width.bottom.equalTo(self)
        }
        self.glskScene!.play(sksFileName: sksFileName ,particleSize: particleSize)
    }
    
    open func stop() {
        guard let skView = skView else { return }
        guard let glskScene = glskScene else { return }
        skView.presentScene(nil)
        skView.removeFromSuperview()
        glskScene.stop()
    }

}


import SpriteKit

class GLSKScene: SKScene {
    
    var skEmitterNode: SKEmitterNode?
    override func didMove(to view: SKView) {
        setScene(view)
    }
       
    override func didApplyConstraints() {
        guard let view = view else { return }
        scene?.size = view.frame.size
    }
    
    private func setScene(_ view: SKView) {
        backgroundColor = .clear
        scene?.anchorPoint = CGPoint(x: 0.5, y: 1)
        scene?.scaleMode = .aspectFill
    }
    
    
    //func startSnow(particleSize: CGSize = CGSize(width: 50, height: 50), completion: @escaping (String) -> Void) {
    func play(sksFileName: String, particleSize: CGSize = CGSize(width: 50, height: 50)) {
        skEmitterNode = SKEmitterNode(fileNamed: sksFileName)
        if let skEmitterNode = skEmitterNode {
            skEmitterNode.particleSize = CGSize(width: particleSize.width, height: particleSize.height)
            skEmitterNode.particleLifetime = 2
            skEmitterNode.particleLifetimeRange = 6
            // 중앙 상단으로 세팅
            skEmitterNode.position = .zero
            scene?.addChild(skEmitterNode)
            print("Initialize Success Emitter Node")
        } else {
            print("Can't Assign Emitter Node, Please check your \"sks\" file")
        }
        
    }
    
    func stop() {
        guard let skEmitterNode = skEmitterNode else { return }
        skEmitterNode.particleBirthRate = 0.0
        skEmitterNode.targetNode = nil
        skEmitterNode.removeFromParent()
        self.skEmitterNode = nil
    }
    
}
