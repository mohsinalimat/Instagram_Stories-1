//
//  IGHomeController.swift
//  InstagramStories
//
//  Created by Ranjith Kumar on 9/6/17.
//  Copyright © 2017 Dash. All rights reserved.
//

import UIKit

final class IGHomeController: UIViewController {
    
    private var _view:IGHomeView{return view as! IGHomeView}
    private var viewModel:IGHomeViewModel = IGHomeViewModel()
    
    override func loadView() {
        super.loadView()
        view = IGHomeView.init(frame: UIScreen.main.bounds)
        _view.collectionView.delegate = self
        _view.collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        automaticallyAdjustsScrollViewInsets = false
    }
}

extension IGHomeController:UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IGAddStoryCell.reuseIdentifier(),for: indexPath) as? IGAddStoryCell else { return UICollectionViewCell() }
            return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IGStoryListCell.reuseIdentifier(),for: indexPath) as? IGStoryListCell else { return UICollectionViewCell() }
            let story = viewModel.cellForItemAt(indexPath: indexPath)
            cell.story = story
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            debugPrint("Need to implement!")
        }else{
            let storyPreviewScene = IGStoryPreviewController.init(stories: viewModel.getStories()!, handPickedStoryIndex: indexPath.row-1)
            present(storyPreviewScene, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.row == 0 ? CGSize(width: 100, height: 100) : CGSize(width: 80, height: 100)
    }
}
