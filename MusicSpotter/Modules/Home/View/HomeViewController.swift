//
//  HomeViewController.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var greetingLabel : UILabel!
    @IBOutlet weak var tableView:UITableView!
    
    var userName = ""
    private let defaultArtist = "jack+jhonson"
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName = UserDefaults.standard.string(forKey: "UserName") ?? ""
        greetingLabel.text = "Hey \(userName) 👋🏻"
        setUptableView()
        fetchDataFromAPI()
    }
    
    private func setUptableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(SongListTableViewCell.self)
    }
    
    @IBAction func searchAction(_ sender:UIButton){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController")as? SearchViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func MenuAction(_ sender:UIButton){
        showLogoutAlert()
    }
    private func fetchDataFromAPI(){
        viewModel.fetchData(searchText:defaultArtist ) { msg, status in
            if self.viewModel.model?.resultCount != 0{
                self.tableView.reloadData()
            }
        } onFailure: { errMsg in
            self.showAlert(message: errMsg, tittle: "Error")
        }
    }
    func showLogoutAlert() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            UserDefaults.standard.removeObject(forKey: "UserEmail")
            UserDefaults.standard.removeObject(forKey: "UserName")
            
            guard let signInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else {
                return
            }
            
            let navController = UINavigationController(rootViewController: signInVC)
            navController.navigationBar.isHidden = true
            UIApplication.shared.windows.first?.rootViewController = navController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        alert.addAction(logoutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }



}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SongListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        if let data = self.viewModel.model?.results[indexPath.row]{
            cell.configureCell(icon: data.artworkUrl100, name: data.trackName, author: data.artistName)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController")as? DetailedViewController{
            if let data = self.viewModel.model?.results[indexPath.row]{
                vc.data = data
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
