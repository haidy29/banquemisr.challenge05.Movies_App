//
//  MovieCoreData.swift
//  banquemisr.challenge05.Movies_App
//
//  Created by Sohila Ahmed on 29/09/2024.
//

import UIKit
import CoreData

class CoreDataManager {
    static var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found")
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    static func saveMoviesToCoreData(data: [Movie], entityName: MoviesEntity) {
        guard let myContext = context,
              let entity = NSEntityDescription.entity(forEntityName: entityName.rawValue, in: myContext) else {
            return
        }

        do {
            for movie in data {
                let myMovie = NSManagedObject(entity: entity, insertInto: myContext)
                myMovie.setValue(movie.title, forKey: "title")
                myMovie.setValue(movie.releaseDate, forKey: "releaseDate")
                myMovie.setValue(movie.posterPath, forKey: "posterPath")
                myMovie.setValue(movie.id, forKey: "id") // Assuming Movie has an id property
            }

            try myContext.save()
            print("Saved Successfully")
        } catch {
            print("Failed to save Movies data: \(error.localizedDescription)")
        }
    }
    
    static func fetchMoviesFromCoreData(entityName: MoviesEntity) -> [Movie] {
        guard let myContext = context else {
            return []
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName.rawValue)
        var arrayOfMovies: [Movie] = []
        
        do {
            let savedMovies = try myContext.fetch(fetchRequest)
            for item in savedMovies {
                let title = item.value(forKey: "title") as? String
                let releaseDate = item.value(forKey: "releaseDate") as? String
                let posterPath = item.value(forKey: "posterPath") as? String
                let id = item.value(forKey: "id") as? Int
                
                let movie = Movie(id: id, posterPath: posterPath, releaseDate: releaseDate, title: title)
                arrayOfMovies.append(movie)
            }
        } catch {
            print("Failed to fetch Movies: \(error.localizedDescription)")
        }
        
        return arrayOfMovies
    }
    
    static func deleteAllDataThenSave(data: [Movie], entityName: MoviesEntity) {
        guard let myContext = context else {
            return
        }

        // Use NSFetchRequest<NSFetchRequestResult>
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName.rawValue)
        
        do {
            // Perform batch delete request
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try myContext.execute(batchDeleteRequest)
            print("Data cleared successfully!")
            
        } catch {
            print("Error during batch delete: \(error.localizedDescription)")
        }

        // Save new movies to Core Data
        saveMoviesToCoreData(data: data, entityName: entityName)
    }



}



//class CoreDataManager {
//    static var context : NSManagedObjectContext?
//    static var appDelegate : AppDelegate?
//
//    static func saveMoviesToCoreData(data:[Movie], entityName: MoviesEntity) {
//
//        appDelegate = UIApplication.shared.delegate as? AppDelegate
//
//        context = appDelegate?.persistentContainer.viewContext
//        guard let myContext = context else{return}
//
//        let entity = NSEntityDescription.entity(forEntityName: entityName.rawValue, in: myContext)
//
//        guard let myEntity = entity else{return}
//        do {
//            for movies in data {
//                let myMovies = NSManagedObject(entity: myEntity, insertInto: context)
//
//                myMovies.setValue(movies.title, forKey: "title")
//                myMovies.setValue(movies.releaseDate, forKey: "releaseDate")
//                myMovies.setValue(movies.posterPath, forKey: "posterPath")
//                myMovies.setValue(movies.id, forKey: "id")
//            }
//
//            try myContext.save()
//            print("Saved Successfully")
//
//        } catch let error {
//            print("Failed to save Movies data: \(error.localizedDescription)")
//        }
//    }
//
//    static func fetchMoviesFromCoreData(entityName: MoviesEntity) ->[Movie] {
//        appDelegate = UIApplication.shared.delegate as? AppDelegate
//
//        context = appDelegate?.persistentContainer.viewContext
//
//        let fetch = NSFetchRequest<NSManagedObject>(entityName: entityName.rawValue)
//
//        var arrayOfMovies : [Movie] = []
//
//        do{
//            let savedMovies = try context?.fetch(fetch)
//
//            guard let myItems = savedMovies else{return []}
//
//            for item in myItems {
//                // Use optional binding to safely unwrap values
//                let title = item.value(forKey: "title")
//                let releaseDate = item.value(forKey: "releaseDate")
//                let posterPath = item.value(forKey: "posterPath")
//                let id = item.value(forKey: "id")
//
//                let product = Movie(id: id as? Int, posterPath: posterPath as? String, releaseDate: releaseDate as? String, title: title as? String )
//                arrayOfMovies.append(product)
//
//            }
//
//        }catch let error {
//            print(error.localizedDescription)
//        }
//        return arrayOfMovies
//    }
//
//    static func deleteAllDataThenSave(data: [Movie], entityName: MoviesEntity) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//
//        let context = appDelegate.persistentContainer.viewContext
//
//        do {
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName.rawValue)
//            let existingData = try context.fetch(fetchRequest)
//
//            // Check if there's data to delete
//            if existingData.isEmpty {
//                print("No data found to delete.")
//            } else {
//                // Create a copy of the existing data for deletion
//                let objectsToDelete = Array(existingData)
//                for object in objectsToDelete {
//                    context.delete(object)
//                }
//
//                // Save the context after deleting
//                try context.save()
//                print("Data cleared successfully!")
//            }
//        } catch {
//            print("Error during fetch/delete: \(error.localizedDescription)")
//        }
//
//        // Save new movies to Core Data
//        saveMoviesToCoreData(data: data, entityName: entityName)
//    }
//
//
//
//
//    //    static func deleteFromFavCoreData( selectedId :Int)
//    //    {
//    //        appDelegate = UIApplication.shared.delegate as? AppDelegate
//    //
//    //        context = appDelegate?.persistentContainer.viewContext
//    //
//    //        do{
//    //            let fetch = NSFetchRequest<NSManagedObject>(entityName: "Favoutites")
//    //            let predictt = NSPredicate(format: "leagueKey == %d",selectedId)
//    //            fetch.predicate = predictt
//    //
//    //            let favProducts = try context?.fetch(fetch)
//    //
//    //            guard let item = favProducts else {return}
//    //            guard let itemFirst = item.first else {return}
//    //
//    //            context?.delete(itemFirst)
//    //
//    //            try context?.save()
//    //
//    //            print("Deleted Succussfully")
//    //
//    //        }catch let error
//    //        {
//    //            print(error.localizedDescription)
//    //        }
//    //    }
//    //
//    //    static func checkFavCoreData( selectedId :Int) -> Bool{
//    //
//    //        appDelegate = UIApplication.shared.delegate as? AppDelegate
//    //
//    //        context = appDelegate?.persistentContainer.viewContext
//    //
//    //        do{
//    //            let fetch = NSFetchRequest<NSManagedObject>(entityName: "Favoutites")
//    //            let predictt = NSPredicate(format: "leagueKey == %d",selectedId)
//    //            fetch.predicate = predictt
//    //
//    //            let favProducts = try context?.fetch(fetch)
//    //
//    //            guard let item = favProducts else {return false}
//    //            guard let itemFirst = item.first else {return false}
//    //
//    //
//    //            print("founded Succussfully")
//    //            return true
//    //
//    //        }catch let error
//    //        {
//    //            print(error.localizedDescription)
//    //            return false
//    //        }
//    //    }
//
//}

enum MoviesEntity: String{
    case NowPlayingMovies = "NowPlayingMovies"
    case PopularMovies = "PopularMovies"
    case UpcomingMovies = "UpcomingMovies"
}
