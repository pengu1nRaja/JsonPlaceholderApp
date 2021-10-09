//
//  UserDetailsVC.swift
//  JsonPlaceholderApp
//
//  Created by PenguinRaja on 09.10.2021.
//

import UIKit

class UserDetailsVC: UICollectionViewController {
    
    var userId: Int = 0
    private var photos = [Photo](){
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    private let cellID = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = .white
        fetchUserPhotos(photoId: userId)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchUserPhotos(photoId: Int) {
        NetworkManager.shared.fetchUserPhotos(photoId: photoId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let photos):
                self.photos = photos
                
            case .failure(_):
                print("")
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PhotoCell else { return UICollectionViewCell()}
        
        let imageURL = photos[indexPath.row].url

        DispatchQueue.main.async {
            cell.spinnerView.stopAnimating()
            cell.imageView.fetchImage(from: imageURL)
            cell.spinnerView.isHidden = true
        }

        cell.label.text = photos[indexPath.row].title
        cell.spinnerView.stopAnimating()
        
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 1
        cell.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        
        return cell
    }
}

extension UserDetailsVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: view.frame.width - 16,
            height: view.frame.width + 48
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
