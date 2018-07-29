//
//  ViewController.swift
//  Ikea
//
//  Created by Valerio Potrimba on 28/07/2018.
//  Copyright © 2018 Petru Potrimba. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ARSCNViewDelegate {

    @IBOutlet weak var planeDetected: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var itemsCollection: UICollectionView!
    
    var items: [String] = ["cup", "vase", "boxing", "table"]
    var selectedItem: String?
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.itemsCollection.dataSource = self
        self.itemsCollection.delegate = self
        self.sceneView.delegate = self
        self.registerGestureRecognizer()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! ItemCell
        cell.itemLabel.text = self.items[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) //here i get the index (indexPath) of the cell that is triggered in collectionView
        self.selectedItem = self.items[indexPath.row]
        cell?.backgroundColor = UIColor.green
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    }
    
    func registerGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let tapLocation = sender.location(in: sceneView)
        //this line check if the location where you tapped (tapLocation) matches to an horizontal plane surface
        let hitTest = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        if !hitTest.isEmpty {
            addItem(hitTestResult: hitTest.first!)
        }
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let pinchLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(pinchLocation)
        if !hitTest.isEmpty {
            let result = hitTest.first
            let node = result?.node
            let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
            print(sender.scale)
            node?.runAction(pinchAction)
            sender.scale = 1.0
        }
    }
    
    func addItem(hitTestResult: ARHitTestResult) {
        if let selectedItem = self.selectedItem {
            let scene =  SCNScene(named: "Models.scnassets/\(selectedItem).scn")
            print(selectedItem)
            //now from the scene need to extract out node
            let node = (scene?.rootNode.childNode(withName: selectedItem, recursively: false))!
            let transform = hitTestResult.worldTransform //this transform matrix encodes the position of the detected surface in the third coloumn
            let thirdCol = transform.columns.3
            node.position = SCNVector3(thirdCol.x, thirdCol.y, thirdCol.z)
            self.sceneView.scene.rootNode.addChildNode(node)
        }
    }
    //this function is triggered everytime an anchor is placed (which means that a new plane has been detected)
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {return}
        DispatchQueue.main.async {
            self.planeDetected.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.planeDetected.isHidden = true
        }
    }
}

