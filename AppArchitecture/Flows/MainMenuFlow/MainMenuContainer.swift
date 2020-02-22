//
//  MainMenuContainer.swift
//  example
//
//  Created by Alex on 4/9/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import Swinject
import RealmSwift
import RCKit


func buildMainMenuContainer(parent: Container)->Container{
    let container = Container(parent: parent)
    
    container.register(Realm.Configuration.self) { (_) -> Realm.Configuration in
        return Realm.Configuration.defaultConfiguration
    }
    
    container.register(URLSession.self) { (resolver) -> URLSession in
        return URLSession.shared
    }
    
    container.register(Scheduler.self) { (_) -> Scheduler in
        return Scheduler.init(threadName: "com.realm.thread")
    }.inObjectScope(.weak)
    
    container.register(RequestFactory.self) { (_) -> RequestFactory in
        return DefaultRequestFactory()
    }
    
    container.register(RequestFactory.self) { (_) -> RequestFactory in
        return DefaultRequestFactory()
    }
    
    container.register(HTTPRequestPerformer.self) { (resolver) -> HTTPRequestPerformer in
        return DefaultHTTPRequestPerformer(session: resolver.resolve(URLSession.self)!)
    }
    
    container.register(ModelRemoteRepository.self) { (resolver) -> ModelRemoteRepository in
        return DefaultModelRemoteRepository(requestFactory: resolver.resolve(RequestFactory.self)!, httpPerformer: resolver.resolve(HTTPRequestPerformer.self)!)
    }
    
    container.register(ModelLocalRepository.self) { (resolver) -> ModelLocalRepository in
        return DefaultModelLocalRepository(configuration: resolver.resolve(Realm.Configuration.self)!, scheduler: resolver.resolve(Scheduler.self)!)
    }
    
    container.register(ModelManager.self) { (resolver) -> ModelManager in
        return DefaultModelManager(modelLocalRepository: resolver.resolve(ModelLocalRepository.self)!, modelRemoteRepository: resolver.resolve(ModelRemoteRepository.self)!)
    }
    
    container.register(ListFactory.self) { (resolver) -> ListFactory in
        return DefaultListFactory(container: resolver as! Container)
    }
    
    container.register(DetailFactory.self) { (resolver) -> DetailFactory in
        return DefaultDetailFactory(container: resolver as! Container)
    }
    
    
    return container
}
