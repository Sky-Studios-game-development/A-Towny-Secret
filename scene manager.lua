scene = {}
scene.manager = {}
scene.scenes = {}

function scene.manager.load()
    scene.manager.current = {}


    scene.scenes = {}
end

function scene.manager.createScene(name, id, objects, people, background, triggerboxes, onswitchfunct)
    name = name
    id = id
    objects = objects
    people = people
    background = background
    triggerboxes = triggerboxes
    onswitchfunct = onswitchfunct
    table.insert(scene.scenes, {name = name, id = id, objects = objects, people = people, background = background, triggerboxes = triggerboxes, onswitchfunct = onswitchfunct})
end

function scene.manager.switchScene(id)
    if scene.scenes[id] ~= nil then
        for i = 1, #scene.scenes do
            if scene.scenes[i].id == id then
                scene.manager.current = scene.scenes[i]

                for c = 1, #scene.scenes[i].objects do
                    engine.createObject(scene.scenes[i].objects[c].name, scene.scenes[i].objects[c].id, scene.scenes[i].objects[c].x, scene.scenes[i].objects[c].y, scene.scenes[i].objects[c].width, scene.scenes[i].objects[c].height, scene.scenes[i].objects[c].img, scene.scenes[i].objects[c].tangable, scene.scenes[i].objects[c].colidefunction)
                end

                for c = 1, #scene.scenes[i].people do
                    engine.createPerson(scene.scenes[i].people[c].name, scene.scenes[i].people[c].id, scene.scenes[i].people[c].x, scene.scenes[i].people[c].y, scene.scenes[i].people[c].width, scene.scenes[i].people[c].height, scene.scenes[i].people[c].img, scene.scenes[i].people[c].colidefunction)
                end

                for c = 1, #scene.scenes[i].triggerboxes do
                    engine.createtriggerbox(scene.scenes[i].triggerboxe[c].id, scene.scenes[i].triggerboxe[c].x, scene.scenes[i].triggerboxe[c].y, scene.scenes[i].triggerboxe[c].width, scene.scenes[i].triggerboxe[c].height, scene.scenes[i].triggerboxe[c].triggerfunction)
                end

                scene.scenes[i].onswitchfunct()
            end
        end
    end
end