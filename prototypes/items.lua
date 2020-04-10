data:extend({
  {
    type = "item",
    name = "train-tracker",
    icon = "__Vehicle_Radar__/graphics/radar2_icon.png",
    icon_size = 32,
    subgroup = "transport",
    order = "a[train-system]-x[train-tracker]",
    place_result = "train-tracker",
    stack_size = 5
  },
  {
    type = "item",
    name = "vehicular-tracker",
    icon = "__Vehicle_Radar__/graphics/radar1_icon.png",
    icon_size = 32,
    subgroup = "transport",
    order = "b[vehicles]-x[vehicular-tracker]",
    place_result = "vehicular-tracker",
    stack_size = 5
  },
})