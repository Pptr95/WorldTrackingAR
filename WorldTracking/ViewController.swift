//
//  ViewController.swift
//  WorldTracking
//
//  Created by Valerio Potrimba on 25/07/2018.
//  Copyright © 2018 Petru Potrimba. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBAction func reset(_ sender: Any) {
        self.resetSession()
    }
    @IBAction func add(_ sender: UIButton) {
        let node = SCNNode()
        //node.geometry = SCNCone(topRadius: 0.3, bottomRadius: 0.3, height: 0.1)
        //node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        //node.geometry = SCNCylinder(radius: 0.3, height: 0.1)
        //node.geometry = SCNSphere(radius: 0.2)
        //node.geometry = SCNTube(innerRadius: 0.1, outerRadius: 0.1, height: 0.2)
        //node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.03)
        //node.geometry = SCNPlane(width: 0.3, height: 0.3)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: 0.2))
        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        path.addLine(to: CGPoint(x: 0.4, y: 0.0))
        let shape = SCNShape(path: path, extrusionDepth: 0.1)
        node.geometry = shape
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        /*let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)*/
        node.position = SCNVector3(0, 0, 0)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    func resetSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _)
            in node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) ->CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }

}

