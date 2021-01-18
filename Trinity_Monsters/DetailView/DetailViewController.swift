//
//  DetailViewController.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 14.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var plotText: UITextView!
    
    var viewModel: DetailViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configurView()
        viewModel?.setMovie()
        setBackdrop()
        viewModel?.loadImage()
    }
    
    private func configurView() {
        viewModel?.updateData = { [weak self] movie in
            self?.titleLabel.text = movie?.title
            self?.plotText.text = movie?.overview
        }
    }
    
    private func setBackdrop() {
        viewModel?.updateBackdrop = { [weak self] image in
            self?.bindImage(image)
        }
    }
    
    func bindImage(_ observable: Observable<UIImage?>) {
        observable.bind(to: detailImage.rx.image).disposed(by: disposeBag)
    }
}
