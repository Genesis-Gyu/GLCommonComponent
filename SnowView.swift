//
//  SnowView.swift
//  GLCommonComponent
//
//  Created by Gyu on 2022/11/22.
//

import UIKit

public class SnowView: UIView {

    private var snowSkView: SKView?
    private var snowScene: SnowScene?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**sksFileName = Sprite Kit Particle file Name*/
    open func startSnow(sksFileName: String, particleSize: CGSize = CGSize(width: 50, height: 50)) {
        stopSnow()
        snowSkView = SKView()
        snowSkView!.backgroundColor = .clear
        snowScene = SnowScene()
        snowSkView!.presentScene(snowScene)
        self.addSubview(snowSkView!)
        snowSkView!.snp.makeConstraints { make in
            make.left.top.equalTo(0)
            make.width.bottom.equalTo(self)
        }
        self.snowScene!.startSnow(sksFileName: sksFileName ,particleSize: particleSize)
    }
    
    open func stopSnow() {
        guard let snowSkView = snowSkView else { return }
        guard let snowScene = snowScene else { return }
        snowSkView.presentScene(nil)
        snowSkView.removeFromSuperview()
        snowScene.stopSnow()
    }

}


import SpriteKit

class SnowScene: SKScene {
    
    var snowEmitterNode: SKEmitterNode?
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
    func startSnow(sksFileName: String, particleSize: CGSize = CGSize(width: 50, height: 50)) {
        snowEmitterNode = SKEmitterNode(fileNamed: sksFileName)
        if let snowEmitterNode = snowEmitterNode {
            snowEmitterNode.particleSize = CGSize(width: particleSize.width, height: particleSize.height)
            snowEmitterNode.particleLifetime = 2
            snowEmitterNode.particleLifetimeRange = 6
            // 중앙 상단으로 세팅
            snowEmitterNode.position = .zero
            scene?.addChild(snowEmitterNode)
            print("Initialize Success Emitter Node")
        } else {
            print("Can't Assign Emitter Node, Please check your \"sks\" file")
        }
        
    }
    
    func stopSnow() {
        guard let snowEmitterNode = snowEmitterNode else { return }
        snowEmitterNode.particleBirthRate = 0.0
        snowEmitterNode.targetNode = nil
        snowEmitterNode.removeFromParent()
        self.snowEmitterNode = nil
    }
    
}
