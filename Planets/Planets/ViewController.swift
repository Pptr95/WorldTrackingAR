//
//  ViewController.swift
//  Planets
//
//  Created by Valerio Potrimba on 26/07/2018.
//  Copyright © 2018 Petru Potrimba. All rights reserved.
//
/*
import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.2)
        earth.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        //earth.geometry?.firstMaterial?.specular.contents = Test
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
*/
import UIKit
import ARKit
class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonParent = SCNNode()
        
        /*This doesn't work in XCode 10
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
        */
        sun.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        sun.position = SCNVector3(0,0,-1)
        earthParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        moonParent.position = SCNVector3(1.2 ,0 , 0)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: UIColor.blue, position: SCNVector3(1.2 ,0 , 0))
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: UIColor.green, position: SCNVector3(0.7, 0, 0))
        let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: UIColor.white, position: SCNVector3(0,0,-0.3))
        
        
        
        let sunAction = self.rotation(time: 8)
        let earthParentRotation = self.rotation(time: 14)
        let venusParentRotation = self.rotation(time: 10)
        let earthRotation = self.rotation(time: 8)
        let moonRotation = self.rotation(time: 5)
        let venusRotation = self.rotation(time: 8)
        
        
        earth.runAction(earthRotation)
        venus.runAction(venusRotation)
        earthParent.runAction(earthParentRotation)
        venusParent.runAction(venusParentRotation)
        moonParent.runAction(moonRotation)
        
        
        sun.runAction(sunAction)
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        venusParent.addChildNode(venus)
        earth.addChildNode(moon)
        moonParent.addChildNode(moon)
        
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIColor, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.position = position
        return planet
        
    }
    
    func rotation(time: TimeInterval) -> SCNAction {
        let rotationTime = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(rotationTime)
        return foreverRotation
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

