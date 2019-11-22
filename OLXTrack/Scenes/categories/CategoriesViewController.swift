//
//  CategoriesViewController.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//
import UIKit

final class CategoriesViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
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
        return items.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.identifier, for: indexPath) as! CategoryCollectionCell
        let model = items[indexPath.row]
        cell.setData(with: (model.title, model.thumbnail ?? ""))
        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pos = collectionView.itemIndex(of: indexPath, in: itemsPerSection)
        viewModel.showItems(of: items[pos], at: pos)
    }
}

extension CategoriesViewController: DynamicWidthCellLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, widthForItemAt indexPath: IndexPath) -> CellWidthType {
        print(indexPath)
        switch indexPath.row {
        case 0:
            return items[indexPath.row].visitsCount > items[indexPath.row + 1].visitsCount ? .mostVisited : .normal
//            return .fillWidth
        case items.count - 1:
            return .fillWidth

        default:
            return .normal
        }
    }
}

extension IndexPath {
    static var zero: IndexPath {
        return IndexPath(row: 0, section: 0)
    }
}
