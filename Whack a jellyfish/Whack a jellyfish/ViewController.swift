//
//  ViewController.swift
//  Whack a jellyfish
//
//  Created by Valerio Potrimba on 27/07/2018.
//  Copyright © 2018 Petru Potrimba. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    let configuration = ARWorldTrackingConfiguration()
    
    @IBAction func reset(_ sender: UIButton) {
    }
    @IBAction func play(_ sender: UIButton) {
        self.addNode()
    }
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        let tapGesturesRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGesturesRecognizer)
    }

    func addNode() {
        let node = SCNNode(geometry: SCNBox(width: 0.05, height: 0.1, length: 0.1, chamferRadius: 0))
        node.position = SCNVector3(0.0, 0.0, -0.1)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if hitTest.isEmpty {
            print("No")
        } else {
            let result = hitTest.first!
            let geometry = result.node.geometry
            print(geometry)
        }
    }
}


