local tracker = table.deepcopy(data.raw["radar"]["radar"])
tracker.name = "train-tracker"
tracker.icon = "__Vehicle_Radar__/graphics/train-tracker-icon.png"
tracker.icon_size = 32
tracker.icon_mipmaps = 1
tracker.minable.result = "train-tracker"
tracker.energy_per_sector = train_tracker.energy_usage * train_tracker.refresh_time .. "kJ"
tracker.max_distance_of_sector_revealed = 0
tracker.max_distance_of_nearby_sector_revealed = 0
tracker.energy_per_nearby_scan = "0J"
tracker.energy_usage = train_tracker.energy_usage .. "kW"
for _,layer in pairs(tracker.pictures.layers) do
  if layer.filename == "__base__/graphics/entity/radar/radar.png" then
    layer.filename = "__Vehicle_Radar__/graphics/train-tracker-entity.png"
    layer.hr_version.filename = "__Vehicle_Radar__/graphics/hr-train-tracker-entity.png"
  end
end

data:extend({
  tracker,
  {
    type = "item",
    name = "train-tracker",
    icon = "__Vehicle_Radar__/graphics/train-tracker-icon.png",
    icon_size = 32,
    subgroup = "transport",
    order = "a[train-system]-x[train-tracker]",
    place_result = "train-tracker",
    stack_size = 5
  },
  {
    type = "recipe",
    name = "train-tracker",
    enabled = false,
    ingredients =
    {
      {"radar", 1},
      {"iron-gear-wheel", 50},
      {"steel-plate", 30},
      {"advanced-circuit", 25},
    },
    result = "train-tracker"
  },
})