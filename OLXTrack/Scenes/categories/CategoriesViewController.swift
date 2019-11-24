//
//  CategoriesViewController.swift
//  OLXTrack
//
//  Created by abuzeid on 11/19/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//
import UIKit

final class CategoriesViewController: UIViewController, Loadable {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var errorLbl: UILabel!

    private var items: [CategoryItem] = []

    var viewModel: CategoriesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        configureCollectionView()
        bindToViewModel()
        viewModel.loadData()
    }

    @IBAction private func moreCategoriesAction(_ sender: UIButton) {
        viewModel.loadMoreCategories()
        sender.isHidden = true
        collectionView.setThreeCellsLayout()
    }
}

// MARK: CategoriesViewController (Private)

private extension CategoriesViewController {
    func configureCollectionView() {
        collectionView.registerNib(CategoryCollectionCell.identifier)
    }

    func bindToViewModel() {
        viewModel.categories.subscribe { [weak self] cats in
            self?.items = cats ?? []
            DispatchQueue.main.async { [weak self] in
                self?.updateError(nil)
                self?.collectionView.reloadData()
            }
        }

        viewModel.showProgress.subscribe { [weak self] show in
            DispatchQueue.main.async { [weak self] in
                self?.showLoading(show: show ?? false)
            }
        }
        viewModel.error.subscribe { [weak self] error in
            DispatchQueue.main.async { [weak self] in
                self?.updateError(error)
            }
        }
    }

    func updateError(_ error: Error?) {
        if let desc = error?.localizedDescription {
            errorLbl.text = desc
            errorLbl.isHidden = false
        } else {
            errorLbl.isHidden = false
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
        cell.setData(with: (model.title, .none))
        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showItems(of: items[indexPath.row], at: indexPath.row)
    }
}

extension CategoriesViewController: DynamicWidthCellLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, widthForItemAt indexPath: IndexPath) -> CellWidthType {
        switch indexPath.row {
        case 0:
            return items[indexPath.row].visitsCount ?? 0 > items[indexPath.row + 1].visitsCount ?? 0 ? .mostVisited : .normal

        case items.count - 1:
            return .lastCell

        default:
            return .normal
        }
    }
}
