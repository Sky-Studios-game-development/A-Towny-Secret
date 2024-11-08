engine = {}
engine.objects = {}
engine.people = {}
engine.background = {}
engine.locationMod = {}
engine.triggerboxes = {}
engine.keyactions = {}

function engine.load()
    engine.debug = false
    engine.debugFeatures = {
        {name = 'hitboxes', value = true}
    }
    engine.objects = {}
    engine.people = {}
    engine.keyactions = {}
    engine.triggerboxes = {}
    --engine.background = {width = 10000, height = 5000, img = love.graphics.newImage("R.jfif")}
    engine.locationMod = {x = 0, y = 0}
end

------------------------

function engine.createObject(name, id, x, y, width, height, img, tangable, colidefunction)
    local name = name
    local id = id
    local x = x
    local y = y
    local width = width
    local height = height
    local img = img
    local tangable = tangable
    local colidefunction = colidefunction
    table.insert(engine.objects, {name = name, id = id, x = x, y = y, width = width, height = height, img = img, tangable = tangable, colidefunction = colidefunction})
end

function engine.moveObject(id, x, y)
    for i = 1, #engine.objects do
        if engine.objects[i].id == id then
            engine.objects[i].x = x
            engine.objects[i].y = y
        end
    end
end

function engine.removeObject(id)
    for i = 1, #engine.objects do
        if engine.objects[i].id == id then
            table.remove(engine.objects, i)
        end
    end
end

function engine.runfunction(x, y)
    for i = 1, #engine.objects do
        if engine.objects[i].colidefunction ~= nil then
            if engine.objects[i].x < x + engine.objects[i].width and engine.objects[i].x + engine.objects[i].width > x and engine.objects[i].y < y + engine.objects[i].height and engine.objects[i].y + engine.objects[i].height > y then
                engine.objects[i].colidefunction()
            end
        end
    end
end

function engine.moveallobjects(x, y)
    for i = 1, #engine.objects do
        engine.objects[i].x = engine.objects[i].x + x
        engine.objects[i].y = engine.objects[i].y + y
    end
end

function engine.objectCollision(x,y,width,height)
    for i = 1, #engine.objects do
        if engine.objects[i].x < x + width/2 and engine.objects[i].x + engine.objects[i].width > x- width/2 and engine.objects[i].y < y + height/2 and engine.objects[i].y + engine.objects[i].height > y - height/2 then
            return true
        end
    end
    return false
end

------------------------

function engine.createtriggerbox(id, x, y, width, height, triggerfunction)
    table.insert(engine.triggerboxes, {id = id,x = x, y = y, width = width, height = height, triggerfunction = triggerfunction})
end

function engine.runtriggerbox(x, y)
    for i = 1, #engine.triggerboxes do
        if x > engine.triggerboxes[i].x and x < engine.triggerboxes[i].x + engine.triggerboxes[i].width and y > engine.triggerboxes[i].y and y < engine.triggerboxes[i].y + engine.triggerboxes[i].height then
            engine.triggerboxes[i].triggerfunction()
        end
    end
end

function engine.movetriggerbox(id, x, y)
    for i = 1, #engine.triggerboxes do
        if engine.triggerboxes[i].id == id then
            engine.triggerboxes[i].x = x
            engine.triggerboxes[i].y = y
        end
    end
end

function engine.removetriggerbox(id)
    for i = 1, #engine.triggerboxes do
        if engine.triggerboxes[i].id == id then
            table.remove(engine.triggerboxes, i)
        end
    end
end

function engine.movealltriggerboxes(x, y)
    for i = 1, #engine.triggerboxes do
        engine.triggerboxes[i].x = engine.triggerboxes[i].x + x
        engine.triggerboxes[i].y = engine.triggerboxes[i].y + y
    end
end

------------------------

function engine.createPerson(name, id, x, y, width, height, img, colidefunction)
    local name = name
    local id = id
    local x = x
    local y = y
    local width = width
    local height = height
    local img = img
    local colidefunction = colidefunction
    local currentPath = nil
    table.insert(engine.people, {name = name, id = id, x = x, y = y, width = width, height = height, img = img, colidefunction = colidefunction, currentPath = currentPath})
end

function engine.movePerson(id, x, y, dt)
    for i = 1, #engine.people do
        if engine.people[i].id == id then
            engine.people[i].x = engine.people[i].x + x*dt
            engine.people[i].y = engine.people[i].y + y*dt
        end
    end
end

function engine.removePerson(id)
    for i = 1, #engine.people do
        if engine.people[i].id == id then
            table.remove(engine.people, i)
        end
    end
end

function engine.createPersonPath(id, pathpoints)
    for i = 1, #engine.people do
        if engine.people[i].id == id then
            engine.people[i].currentPath = pathpoints
        end
    end
end -- designed for use as {{x,y], {x,y}, {x,y}...}

function engine.movePeople(dt)
    for i = 1, #engine.people do
        if engine.people[i].currentPath ~= nil then
            engine.movePerson(engine.people[i].id, engine.people[i].currentPath[1][1], engine.people[i].currentPath[1][2], dt)
            table.remove(engine.people[i].currentPath, 1)
            if engine.people[i].currentPath[1] == nil then
                engine.people[i].currentPath = nil
            end
        end
    end
end

------------------------
---@TODO---create interaction menu

function engine.interaction(x,y, text, key, onpressfunction)

end
------------------------

function engine.createInteractibleObject(name, id, x, y, width, height, img, tangable, InteractDistence, colidefunction)
    local name = name
    local id = id
    local x = x
    local y = y
    local width = width
    local height = height
    local img = img
    local tangable = tangable
    local InteractDistence = InteractDistence
    local colidefunction = colidefunction
    engine.createObject(name, id, x, y, width, height, img, tangable, nil)
    engine.createtriggerbox(id,x - InteractDistence, y - InteractDistence, width + 2*InteractDistence, height + 2*InteractDistence, colidefunction)

end

------------------------

function engine.createkeyaction(key, onpressfunction)
    table.insert(engine.keyactions, {key = key, onpressfunction = onpressfunction})
end

function engine.runkeyaction(dt)
    for i = 1, #engine.keyactions do
        if love.keyboard.isDown(engine.keyactions[i].key) then
            engine.keyactions[i].onpressfunction()
        end
    end
end

------------------------
--Main loop--

function engine.update(dt)
    engine.runkeyaction(dt)
    engine.movePeople(dt)
end