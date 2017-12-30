require("config")

---------------------------------------------------------------------------------------------------

function init_force(force)
  global.trains[force.name] = {}
  global.vehicles[force.name] = {}
  for _,surface in pairs(game.surfaces) do
    local locomotives = surface.find_entities_filtered{force = force, type = "locomotive"}
    for _,loco in pairs(locomotives) do
      table.insert(global.trains[force.name], loco)
      -- if loco.grid then
        -- local grid_contents = loco.grid.get_contents()
        -- if grid_contents then
          -- for equipment, count in pairs (grid_contents) do
            -- if equipment == "tracker-module" then
              -- log("[VT] Found "..count.." tracker modules in locomotive "..loco.backer_name)
              -- table.insert(global.trains[force.name], loco)
              -- break
            -- end
          -- end
        -- end
      -- end
    end

    local cars = surface.find_entities_filtered{force = force, type = "car"}
    for _,car in pairs(cars) do
      table.insert(global.vehicles[force.name], car)
      -- if car.grid then
        -- local grid_contents = car.grid.get_contents()
        -- if grid_contents then
          -- for equipment, count in pairs (grid_contents) do
            -- if equipment == "tracker-module" then
              -- log("[VT] Found "..count.." tracker modules in vehicle")
              -- table.insert(global.vehicles[force.name], car)
              -- break
            -- end
          -- end
        -- end
      -- end
    end

  end
  log("[VT] Found "..#global.trains[force.name].." trains for force "..force.name)
  log("[VT] Found "..#global.vehicles[force.name].." vehicles for force "..force.name)
end

function init()
  global.trains = global.trains or {}
  global.vehicles = global.vehicles or {}
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

-- script.on_event(defines.events.on_player_placed_equipment, function(event)
  -- for unit, entity in pairs(global.vehicles) do
    -- if(entity.valid) then
      -- if(entity.grid == event.grid) then
        -- update_equipment(unit, event.grid)
        -- break
      -- end
    -- else
      -- global.vehicles[unit] = nil
      -- global.braking_vehicles[unit] = nil
      -- transformer_for_unit[unit] = nil
      -- regen_brake_for_unit[unit] = nil
    -- end
  -- end
-- end)

-- script.on_event(defines.events.on_player_removed_equipment, function(event)
  -- for unit, entity in pairs(global.vehicles) do
    -- if(entity.valid) then
      -- if(entity.grid == event.grid) then
        -- update_equipment(unit, event.grid)
        -- break
      -- end
    -- else
      -- global.vehicles[unit] = nil
      -- global.braking_vehicles[unit] = nil
      -- transformer_for_unit[unit] = nil
      -- regen_brake_for_unit[unit] = nil
    -- end
  -- end
-- end)

script.on_event(defines.events.on_built_entity, function(event)
	local entity = event.created_entity
	if entity.type == "locomotive" then
		table.insert(global.trains[entity.force.name], entity)
	end
	if entity.type == "car" then
		table.insert(global.vehicles[entity.force.name], entity)
	end
end)

script.on_event(defines.events.on_sector_scanned, function(event)
	if event.radar.name == "train-tracker" then
		local force = event.radar.force
    -- log("[VT] scanning "..#global.trains[force.name].." trains for "..force.name)
		for i=#global.trains[force.name], 1, -1 do
      local loco = global.trains[force.name][i]
			if loco.valid then

				local x1 = loco.position.x
				local y1 = loco.position.y
				local x2 = x1 + loco.train.speed * train_tracker.precognotion * math.sin(2*math.pi * loco.orientation)
				local y2 = y1 - loco.train.speed * train_tracker.precognotion * math.cos(2*math.pi * loco.orientation)

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

        local scalf = train_tracker.scan_radius
				-- log("[VT] charting {"..x1-scalf..", "..y1-scalf.."}, {"..x2+scalf..", "..y2+scalf.."}")
				force.chart(event.radar.surface,{{x1-scalf, y1-scalf}, {x2+scalf, y2+scalf}})
			else
				table.remove(global.trains[force.name], i)
			end
		end
	elseif event.radar.name == "vehicular-tracker" then
		local force = event.radar.force
    -- log("[VT] scanning "..#global.vehicles[force.name].." vehicles for "..force.name)
    for i=#global.vehicles[force.name], 1, -1 do
      local vehicle = global.vehicles[force.name][i]
			if vehicle.valid then

				local x1 = vehicle.position.x
				local y1 = vehicle.position.y

				local scalf = vehicle_tracker.scan_radius
        -- log("[VT] charting {"..x1-scalf..", "..y1-scalf.."}, {"..x1+scalf..", "..y1+scalf.."}")
				force.chart(event.radar.surface,{{x1-scalf, y1-scalf}, {x1+scalf, y1+scalf}})
			else
				table.remove(global.vehicles[force.name], i)
			end
		end
	end
end)
