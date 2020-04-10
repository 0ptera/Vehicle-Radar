
local config = require("config")


local train_tracker = optera_lib.copy_prototype(data.raw["radar"]["radar"], "train-tracker")
train_tracker.icon = "__Vehicle_Radar__/graphics/radar2_icon.png"
train_tracker.icon_size = 32
train_tracker.icon_mipmaps = 1
train_tracker.collision_box = {{-0.45, -0.45}, {0.45, 0.45}}
train_tracker.selection_box = {{-0.7, -0.7}, {0.7, 0.7}}
train_tracker.pictures = {
  filename = "__Vehicle_Radar__/graphics/radar2_entity.png",
  priority = "low",
  width = 160,
  height = 160,
  apply_projection = false,
  direction_count = 64,
  line_length = 8,
  shift = {1.40, -1.80}
}
train_tracker.energy_per_sector = config.train_tracker.energy_usage * config.train_tracker.refresh_time .. "kJ"
train_tracker.energy_usage = config.train_tracker.energy_usage .. "kW"
train_tracker.energy_per_nearby_scan = "0J"
train_tracker.max_distance_of_sector_revealed = 0
train_tracker.max_distance_of_nearby_sector_revealed = 0
train_tracker.corpse = "1x2-remnants"
train_tracker.integration_patch = nil
train_tracker.water_reflection = {
  pictures =
  {
    filename = "__base__/graphics/entity/big-electric-pole/big-electric-pole-reflection.png",
    priority = "extra-high",
    width = 16,
    height = 32,
    shift = util.by_pixel(0, 60),
    variation_count = 1,
    scale = 5,
  },
  rotate = false,
  orientation_to_variation = false
}

local vehicle_tracker = optera_lib.copy_prototype(train_tracker, "vehicular-tracker")
vehicle_tracker.icon = "__Vehicle_Radar__/graphics/radar1_icon.png"
vehicle_tracker.pictures = {
  filename = "__Vehicle_Radar__/graphics/radar1_entity.png",
  priority = "low",
  width = 160,
  height = 160,
  apply_projection = false,
  direction_count = 64,
  line_length = 8,
  shift = {1.45, -1.60}
}
vehicle_tracker.energy_per_sector = config.vehicle_tracker.energy_usage * config.vehicle_tracker.refresh_time .. "kJ"
vehicle_tracker.energy_usage = config.vehicle_tracker.energy_usage .. "kW"

data:extend({ vehicle_tracker, train_tracker })