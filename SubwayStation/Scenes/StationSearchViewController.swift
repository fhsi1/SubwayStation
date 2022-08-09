//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by Yujean Cho on 2022/08/08.
//

import Alamofire
import SnapKit
import UIKit

class StationSearchViewController: UIViewController {
    private var numberOfCells: Int = 0
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
        setTableViewLayout()
        
        requestStationName()
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title  = "Subway"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Please fill in the subway stataion."
        
        // searchController 표시되고 있을 때 하단을 어둡게 처리할 것인지
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        
    }
    
    private func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func requestStationName() {
        let urlString = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/서울역"
        
        AF
            .request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") // url 내의 한글 깨짐 방지처리
            .responseDecodable(of: StationResponseModel.self) { response in
                // 성공했을 때의 파싱된 데이터값만 필요로 하므로 filtering
                guard case .success(let data) = response.result else { return }
                
                print(data.stations)
            }
            .resume()
    }

}

extension StationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.item)"
        
        return cell
    }
}

extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StationDetailViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StationSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        numberOfCells = 10
        tableView.reloadData()
        tableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        numberOfCells = 0
        tableView.isHidden = true
    }
}
