local tracker = table.deepcopy(data.raw["radar"]["radar"])
tracker.name = "vehicular-tracker"
tracker.icon = "__Vehicle_Radar__/graphics/car-tracker-icon.png"
tracker.icon_size = 32
tracker.icon_mipmaps = 1
tracker.minable.result = "vehicular-tracker"
tracker.energy_per_sector = vehicle_tracker.energy_usage * vehicle_tracker.refresh_time .. "kJ"
tracker.max_distance_of_sector_revealed = 0
tracker.max_distance_of_nearby_sector_revealed = 0
tracker.energy_per_nearby_scan = "0J"
tracker.energy_usage = vehicle_tracker.energy_usage .. "kW"
for _,layer in pairs(tracker.pictures.layers) do
  if layer.filename == "__base__/graphics/entity/radar/radar.png" then
    layer.filename = "__Vehicle_Radar__/graphics/car-tracker-entity.png"
    layer.hr_version.filename = "__Vehicle_Radar__/graphics/hr-car-tracker-entity.png"
  end
end

data:extend({
  tracker,
  {
    type = "item",
    name = "vehicular-tracker",
    icon = "__Vehicle_Radar__/graphics/car-tracker-icon.png",
    icon_size = 32,
    subgroup = "transport",
    order = "b[vehicles]-x[vehicular-tracker]",
    place_result = "vehicular-tracker",
    stack_size = 5
  },
  {
    type = "recipe",
    name = "vehicular-tracker",
    enabled = false,
    ingredients =
    {
      {"radar", 1},
      {"iron-gear-wheel", 50},
      {"steel-plate", 30},
      {"advanced-circuit", 25},
    },
    result = "vehicular-tracker"
  },
})