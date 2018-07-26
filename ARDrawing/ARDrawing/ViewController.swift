//
//  ViewController.swift
//  ARDrawing
//
//  Created by Valerio Potrimba on 26/07/2018.
//  Copyright © 2018 Petru Potrimba. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.delegate = self
        self.sceneView.session.run(configuration)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        print("rendering")
        guard let pointOfView = self.sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33) //orientation of the camera is located in a matrix, more specifically in the third column. Row 1 -> x, row 2 -> y, row 3 -> z
        let location = SCNVector3(transform.m41, transform.m42, transform.m43) //location is located in the fourth colums
        let currentPositionOfCamera = orientation + location
        print(orientation.x, orientation.y, orientation.z)
    }
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}
