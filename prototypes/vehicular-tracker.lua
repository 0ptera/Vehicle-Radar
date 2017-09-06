data:extend({
  {
    type = "item",
    name = "vehicular-tracker",
    icon =  "__Vehicle_Radar__/graphics/car-tracker-icon.png",
    flags = {"goes-to-quickbar"},
    subgroup = "transport",
    order = "a[vehicle-system]-h[vehicular-tracker]",
    place_result = "vehicular-tracker",
    stack_size = 5
  },
  {
    type = "radar",
    name = "vehicular-tracker",
    icon =  "__Vehicle_Radar__/graphics/car-tracker-icon.png",
    flags = {"placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 1.5, result = "vehicular-tracker"},
    max_health = 500,
    corpse = "big-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    energy_per_sector = vehicle_tracker.energy_usage * vehicle_tracker.refresh_time .. "kJ",
    max_distance_of_sector_revealed = 0,
    max_distance_of_nearby_sector_revealed = 0,
    energy_per_nearby_scan = "0J",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = vehicle_tracker.energy_usage .. "kW",
    pictures =
    {
      filename = "__Vehicle_Radar__/graphics/car-tracker-entity.png",
      priority = "low",
      width = 153,
      height = 131,
      apply_projection = false,
      direction_count = 64,
      line_length = 8,
      shift = util.by_pixel(27.5,-12.5)
    },
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/radar.ogg"
        }
      },
      apparent_volume = 1.5,
    },
    radius_minimap_visualisation_color = { r = 0.059, g = 0.092, b = 0.235, a = 0.275 },
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