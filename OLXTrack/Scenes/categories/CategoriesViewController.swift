//
//  CategoriesViewController.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//
import UIKit

final class CategoriesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: CategoriesViewModel!
    private var items: [CategoryItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        configureCollectionView()
        bindToViewModel()
        viewModel.loadData()
    }
}

// MARK: CategoriesViewController (Private)

private extension CategoriesViewController {
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(CategoryCollectionCell.identifier)
    }

    func bindToViewModel() {
        viewModel.categories.subscribe { [unowned self] cats in
            self.items = cats ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    var itemsPerSection: Int { return 2 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.numberOfItems(in: section, count: items.count, itms: itemsPerSection)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionView.number(of: itemsPerSection, ofArray: items.count)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.identifier, for: indexPath) as! CategoryCollectionCell
        let model = items[collectionView.itemIndex(of: indexPath, in: itemsPerSection)]
        cell.setData(with: (model.title,model.thumbnail))
        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showItems(of: items[collectionView.itemIndex(of: indexPath, in: itemsPerSection)])
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    var itemPadding: CGFloat { return CGFloat(8) }
    var sectionPadding: CGFloat { return CGFloat(12) }

    var itemSize: CGSize {
        let cellWidth = collectionView.bounds.width / CGFloat(itemsPerSection)
        let margin = CGFloat(1) / CGFloat(itemsPerSection) * itemPadding
        return CGSize(width: cellWidth , height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
  
}
