//
//  TemplateStore.swift
//  Notify
//
//  Created by Will McGinty on 8/9/21.
//

import Foundation

class TemplateStore: ObservableObject {
    
    @Published var templates: [Template] {
        didSet { TemplateStore.updateStoredTemplates(templates) }
    }
    
    // MARK: Initializers
    init() {
        self.templates = TemplateStore.storedTemplates ?? [.basic, .customKey]
    }

    // MARK: Modifying
    func add(template: Template) {
        templates.append(template)
    }

    func remove(template: Template) {
        templates.removeAll(where: { $0.id == template.id })
    }
}

//// MARK: Storage
private extension TemplateStore {
    
    private static var storageURL: URL {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsUrl.appendingPathComponent("templates")
    }

    static var storedTemplates: [Template]? = {
        guard let data = FileManager.default.contents(atPath: storageURL.path) else { return nil }
        return try? JSONDecoder().decode([Template].self, from: data)
    }()

    static func updateStoredTemplates(_ templates: [Template]) {
        let data = try? JSONEncoder().encode(templates)
        try? data?.write(to: storageURL)
    }
}
