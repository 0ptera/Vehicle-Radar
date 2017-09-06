data:extend({
  {
    type = "item",
    name = "tracker-module",
    icon = "__Vehicle_Radar__/graphics/radar.png",
    icon_size = 128,
    placed_as_equipment_result = "tracker-module",
    flags = {"goes-to-main-inventory"},
    subgroup = "equipment",
    order = "x[tracker-module]",
    stack_size = 10
  },
  {
    type = "movement-bonus-equipment",
    name = "tracker-module",
    sprite =
    {
      filename = "__Vehicle_Radar__/graphics/radar.png",
      width = 128,
      height = 128,
      priority = "medium"
    },
    shape =
    {
      width = 2,
      height = 2,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_consumption = "200kW",
    movement_bonus = 0,
    categories = {"armor"}
  },
  {
    type = "recipe",
    name = "tracker-module",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {"radar", 1},
      {"iron-gear-wheel", 10},
      {"steel-plate", 4},
      {"advanced-circuit", 10},
    },
    result = "tracker-module"
  },
 })