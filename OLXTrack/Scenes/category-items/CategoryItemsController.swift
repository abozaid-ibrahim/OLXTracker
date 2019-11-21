//
//  CategoryItemsController.swift
//  OLXTrack
//
//  Created by abuzeid on 11/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

final class CategoryItemsController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var errorLbl: UILabel!
    var viewModel: CategoryItemsViewModel!

    private var items: [CategorySearchItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        bindToViewModel()
        viewModel.loadData()
    }
}

// MARK: CategoriesViewController (Private)

private extension CategoryItemsController {
    func configureCollectionView() {
        collectionView.registerNib(CategoryCollectionCell.identifier)
    }

    func bindToViewModel() {
viewModel.title.subscribe { [unowned self] value in
    self.title = value
}
        viewModel.categoryItems.subscribe { [unowned self] value in
            DispatchQueue.main.async { [unowned self] in
                self.items = value ?? []
                self.collectionView.reloadData()
            }
        }
        viewModel.error.subscribe { [unowned self] error in
            DispatchQueue.main.async { [unowned self] in
                self.updateError(error)
            }
        }
    }

    private func updateError(_ error: Error?) {
        if let desc = error?.localizedDescription {
            errorLbl.text = desc
            errorLbl.isHidden = false
        } else {
            errorLbl.isHidden = false
        }
    }
}

extension CategoryItemsController: UICollectionViewDataSource {
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
        cell.setData(with:(model.name?.content ?? "",model.images?.small?.content ?? ""))
        return cell
    }
}

extension CategoryItemsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showDetails(of: items[indexPath.row])
    }
}

extension CategoryItemsController: UICollectionViewDelegateFlowLayout {
    var linePadding: CGFloat { return CGFloat(8) }
    var sectionPadding: CGFloat { return CGFloat(12) }

    var itemSize: CGSize {
        let cellWidth = collectionView.bounds.width / CGFloat(itemsPerSection)
        let margin = CGFloat(1) / CGFloat(itemsPerSection) * linePadding

        return CGSize(width: cellWidth - margin, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionPadding
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return linePadding
    }
}
