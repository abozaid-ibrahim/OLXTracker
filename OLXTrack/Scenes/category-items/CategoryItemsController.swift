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
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
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
    func showLoading(show: Bool) {
        show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }

    func configureCollectionView() {
        collectionView.registerNib(CategoryCollectionCell.identifier)
    }

    func bindToViewModel() {
        viewModel.title.subscribe { [weak self] value in
            self?.title = value
        }
        viewModel.categoryItems.subscribe { [weak self] value in
            DispatchQueue.main.async { [weak self] in
                self?.items = value ?? []
                self?.collectionView.reloadData()
            }
        }
        viewModel.error.subscribe { [weak self] error in
            DispatchQueue.main.async { [weak self] in
                self?.updateError(error)
            }
        }
        viewModel.showProgress.subscribe { [weak self] value in
            DispatchQueue.main.async { [weak self] in
                self?.showLoading(show: value ?? false)
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

extension CategoryItemsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.identifier, for: indexPath) as! CategoryCollectionCell
        let model = items[indexPath.row]
        cell.setData(with: (model.name?.content ?? "", model.images?.small?.content ?? ""))
        return cell
    }
}

extension CategoryItemsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showDetails(of: items[indexPath.row])
    }
}

extension CategoryItemsController: UICollectionViewDelegateFlowLayout {
    var itemPadding: CGFloat { return CGFloat(6) }
    var itemsPerSection: Int { return 2 }

    var itemSize: CGSize {
        let margins = CGFloat(itemsPerSection + 1) * itemPadding
        let cellWidth = (collectionView.bounds.width - margins) / CGFloat(itemsPerSection)
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: itemPadding, left: itemPadding, bottom: 0, right: itemPadding)
    }
}
