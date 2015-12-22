//
//  Exercices+CoreDataProperties.swift
//  MyPerformance
//
//  Created by Romain Brunie on 12/22/15.
//  Copyright © 2015 Romain BRUNIE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Exercices {

    @NSManaged var categoryExercise: String?
    @NSManaged var descriptionExercise: String?
    @NSManaged var titleExercise: String?

}
