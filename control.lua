local config = require("config")

---------------------------------------------------------------------------------------------------

function init_force(force)
  global.trains[force.name] = {}
  global.vehicles[force.name] = {}
  for _,surface in pairs(game.surfaces) do
    local locomotives = surface.find_entities_filtered{force = force, type = "locomotive"}
    for _,loco in pairs(locomotives) do
      global.trains[force.name][loco.unit_number] = loco
    end

    local cars = surface.find_entities_filtered{force = force, type = "car"}
    for _,car in pairs(cars) do
      global.vehicles[force.name][car.unit_number] = car
    end

  end
  log("[VT] Found "..table_size(global.trains[force.name]).." trains for force "..force.name)
  log("[VT] Found "..table_size(global.vehicles[force.name]).." vehicles for force "..force.name)
end

function init()
  global.trains = {}
  global.vehicles = {}
  for _,force in pairs(game.forces) do
    init_force(force)
  end
end

script.on_init(function()
  init()
end)

script.on_configuration_changed(function(event)
  init()
end)

script.on_event(defines.events.on_force_created, function(event)
  init_force(event.force)
end)

script.on_event(defines.events.on_forces_merging, function(event)
  global.trains[event.destination.name] = global.trains[event.destination.name] or {}
  for _, train in pairs(global.trains[event.source.name]) do
    table.insert(global.trains[event.destination.name], train)
  end
  global.trains[event.source.name] = nil

  global.vehicles[event.destination.name] = global.vehicles[event.destination.name] or {}
  for _, vehicle in pairs(global.vehicles[event.source.name]) do
    table.insert(global.vehicles[event.destination.name], vehicle)
  end
  global.vehicles[event.source.name] = nil
end)

---------------------------------------------------------------------------------------------------

-- catches script generated locomotives from cargo ships
script.on_event(defines.events.on_train_created, function(event)
  for _, movers in pairs(event.train.locomotives) do
    for _, loco in pairs(movers) do
      global.trains[loco.force.name][loco.unit_number] = loco
    end
  end
end)

script.on_event(defines.events.on_built_entity, function(event)
  local entity = event.created_entity
  if entity.type == "locomotive" then
    global.trains[entity.force.name][entity.unit_number] = entity
  end
  if entity.type == "car" then
    global.vehicles[entity.force.name][entity.unit_number] = entity
  end
end)

script.on_event(defines.events.on_sector_scanned,
  function(event)
    if event.radar.name == "train-tracker" then
      local force = event.radar.force
      for uid, loco in pairs(global.trains[force.name]) do
        if loco.valid then
          local x1 = loco.position.x
          local y1 = loco.position.y
          local x2 = x1 + loco.train.speed * config.train_tracker.precognotion * math.sin(2*math.pi * loco.orientation)
          local y2 = y1 - loco.train.speed * config.train_tracker.precognotion * math.cos(2*math.pi * loco.orientation)

          if x2 < x1 then
            local x = x1
            x1 = x2
            x2 = x
          end
          if y2 < y1 then
            local y = y1
            y1 = y2
            y2 = y
          end
          force.chart(event.radar.surface,{{x1-config.train_tracker.scan_radius, y1-config.train_tracker.scan_radius}, {x2+config.train_tracker.scan_radius, y2+config.train_tracker.scan_radius}})
        else
          global.trains[force.name][uid] = nil
        end
      end
    elseif event.radar.name == "vehicular-tracker" then
      local force = event.radar.force
      for uid, vehicle in pairs(global.vehicles[force.name]) do
        if vehicle.valid then
          local x1 = vehicle.position.x
          local y1 = vehicle.position.y

          force.chart(event.radar.surface,{{x1-config.vehicle_tracker.scan_radius, y1-config.vehicle_tracker.scan_radius}, {x1+config.vehicle_tracker.scan_radius, y1+config.vehicle_tracker.scan_radius}})
        else
          global.vehicles[force.name][uid] = nil
        end
      end
    end
  end,
  { {filter="name", name = "train-tracker"}, {filter="name", name = "vehicular-tracker"} }
)
