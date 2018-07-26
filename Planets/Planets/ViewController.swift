//
//  ViewController.swift
//  Planets
//
//  Created by Valerio Potrimba on 26/07/2018.
//  Copyright © 2018 Petru Potrimba. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.2)
        earth.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        earth.position = SCNVector3(0.0, 0.0, -1.0)
        self.sceneView.scene.rootNode.addChildNode(earth)
        
        let sphere = SCNNode(geometry: SCNSphere(radius: 0.05))
        sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        sphere.position = SCNVector3(0.3, 0.0, 0.0)
        earth.addChildNode(sphere)
        
        let action = SCNAction.rotateBy(x: 0.0, y: CGFloat(360.degreesToRadians), z: 0.0, duration: 8)
        let forever = SCNAction.repeatForever(action)
        earth.runAction(forever)
        
        
        
    }


}

extension Int {
    var degreesToRadians: Double { return Double(self) * Double.pi/180}
}
