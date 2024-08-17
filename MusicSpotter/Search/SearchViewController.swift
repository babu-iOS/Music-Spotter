//
//  SearchViewController.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var searchtextField:UITextField!
    
    private  var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiallSetUp()
    }
    
    private func initiallSetUp(){
        setUptableView()
        hideKeyboardWhenTappedAround()
        searchtextField.delegate = self
        searchtextField.returnKeyType = .search
    }
    
    private func setUptableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(SongListTableViewCell.self)
    }
    
    private func fetchDataFromAPI(){
        if let artist = searchtextField.text {
            viewModel.fetchData(searchText:artist ){ msg, status in
                if self.viewModel.model?.resultCount != 0{
                    self.tableView.reloadData()
                }
            } onFailure: { errMsg in
                self.showAlert(message: errMsg, tittle: "Error")
            }
        }
    }
    @IBAction func backAction(_ sender:UIButton){
            self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController : UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SongListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        if let data = self.viewModel.model?.results[indexPath.row]{
            cell.configureCell(icon: data.artworkUrl100, name: data.trackName, author: data.artistName)
            cell.forwardImage.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchtextField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchtextField {
            searchtextField.resignFirstResponder()
            fetchDataFromAPI()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, (text as NSString).replacingCharacters(in: range, with: string).count >= 2 {
            fetchDataFromAPI()
        }
        return true
    }
}
