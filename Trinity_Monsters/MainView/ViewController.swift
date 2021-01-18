//
//  ViewController.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 14.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

enum CellID {
    static let tableViewCell = "TableViewCell"
}

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    var viewModel: ViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityView.startAnimating()
        bindTableView()
        viewModel?.loadMovie()
        refreshView()
    }

    private func bindTableView() {
        tableView.register(UINib(nibName: CellID.tableViewCell, bundle: nil),
                           forCellReuseIdentifier: CellID.tableViewCell)
        
        viewModel?.movies.bind(to: tableView.rx.items(cellIdentifier: CellID.tableViewCell,
                                                      cellType: TableViewCell.self)) { [weak self] row, _, cell in
            guard let self = self else { return }
            self.viewModel?.willDisplayCell(cell, withIndex: row)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Movie.self).subscribe(onNext: { [weak self] item in
            guard let self = self else { return }
            self.viewModel?.showDetail(view: self, model: item)
        }).disposed(by: disposeBag)
    }
    
    private func refreshView() {
        viewModel?.updateData = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityView.stopAnimating()
                self.activityView.isHidden = true
            }
        }
    }
}
