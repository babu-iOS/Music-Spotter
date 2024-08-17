//
//  CoreDataManager.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private let email = UserDefaults.standard.string(forKey: "UserEmail") ?? ""
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MusicSpotter")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    func saveUser(username: String, email: String, password: String) {
        let context = persistentContainer.viewContext
        let newUser = User(context: context)
        newUser.username = username
        newUser.email = email
        newUser.password = password
        
        do {
            try context.save()
            print("User saved successfully")
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    func fetchUserCredentials(email: String, completion: @escaping (String?, String?,String?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                completion(user.email, user.password,user.username)
            } else {
                completion(nil, nil,nil)
            }
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
            completion(nil, nil,nil)
        }
    }


    func addFavoriteTrack(trackId: String) {
        // Fetch user based on email
        let Useremail = UserDefaults.standard.string(forKey: "UserEmail") ?? ""
        fetchUserCredentials(email: Useremail) { (email, _, _) in
            guard let email = email else {
                print("User not found")
                return
            }
            
            // Add trackId to user's favorites
            let context = self.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            
            do {
                let users = try context.fetch(fetchRequest)
                if let user = users.first {
                    var favoriteTrackIds = user.favoriteTrackIds ?? []
                    favoriteTrackIds.append(trackId)
                    user.favoriteTrackIds = favoriteTrackIds
                    
                    try context.save()
                    print("Favorite track \(trackId) added for user \(email)")
                }
            } catch {
                print("Failed to add favorite track: \(error.localizedDescription)")
            }
        }
    }

    func fetchFavoriteTracks( completion: @escaping ([String]?) -> Void) {
        // Fetch user based on email
        let Useremail = UserDefaults.standard.string(forKey: "UserEmail") ?? ""
        fetchUserCredentials(email: Useremail) { (email, _, _) in
            guard let email = email else {
                print("User not found")
                completion(nil)
                return
            }
            
            // Fetch user's favorite track IDs
            let context = self.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            
            do {
                let users = try context.fetch(fetchRequest)
                if let user = users.first {
                    completion(user.favoriteTrackIds)
                } else {
                    completion(nil)
                }
            } catch {
                print("Failed to fetch favorite tracks: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }


    func removeFavoriteTrack(trackId: String) {
        let Useremail = UserDefaults.standard.string(forKey: "UserEmail") ?? ""
        fetchUserCredentials(email: Useremail) { (email, _, _) in
            guard let email = email else {
                print("User not found")
                return
            }
            
            let context = self.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            
            do {
                let users = try context.fetch(fetchRequest)
                if let user = users.first {
                    if var favoriteTrackIds = user.favoriteTrackIds,
                       let index = favoriteTrackIds.firstIndex(of: trackId) {
                        favoriteTrackIds.remove(at: index)
                        user.favoriteTrackIds = favoriteTrackIds
                        
                        try context.save()
                        print("Favorite track \(trackId) removed for user \(email)")
                    }
                }
            } catch {
                print("Failed to remove favorite track: \(error.localizedDescription)")
            }
        }
    }
}

