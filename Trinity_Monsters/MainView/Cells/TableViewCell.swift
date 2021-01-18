//
//  TableViewCell.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 14.01.2021.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

final class TableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var viewModel: TableCellViewModel?
    private var disposable: Disposable?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
        titleLabel.text = nil
        releaseDateLabel.text = nil
        ratingLabel.text = nil
        disposable?.dispose()
    }
    
    func configurView(withModel model: TableCellViewModel?) {
        viewModel = model
        titleLabel.text = model?.title
        releaseDateLabel.text = "Release: \(model?.releaseDate ?? "")"
        ratingLabel.text = "Rating: \(model?.rating ?? 0)"
    }
    
    func bindImage(_ observable: Observable<UIImage?>) {
        disposable = observable.bind(to: posterImage.rx.image)
    }
}
