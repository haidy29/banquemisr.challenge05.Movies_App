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

enum MoviesEntity: String{
    case NowPlayingMovies = "NowPlayingMovies"
    case PopularMovies = "PopularMovies"
    case UpcomingMovies = "UpcomingMovies"
}
