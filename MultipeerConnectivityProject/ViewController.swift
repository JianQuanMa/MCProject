//
//  ViewController.swift
//  MultipeerConnectivityProject
//
//  Created by Jian Ma on 1/6/20.
//  Copyright © 2020 Jian Ma. All rights reserved.
//
import MultipeerConnectivity
import UIKit

class ViewController: UICollectionViewController {
    var images = [UIImage]()
    var peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCAdvertiserAssistant?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "selfie battle"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }
    
    func startHosting(action: UIAlertAction){
        guard let mcSession = mcSession else{ return }
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "MCProject", discoveryInfo: nil, session: mcSession)
    }
    
    func joinSession(action: UIAlertAction){
        guard let mcSession = mcSession else{ return }
    }

    @objc func importPicture(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    @objc func showConnectionPrompt(){
        let ac = UIAlertController(title: "connect to others", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host A Session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join A Session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Host A session", style: .cancel))
        present(ac, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        dismiss(animated: true)
        images.insert(image, at: 0)
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        if let imageView = cell.viewWithTag(9999) as? UIImageView{
            imageView.image = images[indexPath.item]
        }
        return cell
    }
    
}


extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
}
