import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToListViewController()
    }
    
    func goToListViewController() {
        let viewController = ListViewController()
        viewController.onCellSelected = { repoSelected in
            self.goToDetailViewAt(repoSelected)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToDetailViewAt(_ repoSelected: RepositoryModel) {
        let viewController = DetailViewController()
        viewController.repo = repoSelected
        navigationController.pushViewController(viewController, animated: true)
    }
}
