data:extend({
	{
    type = "technology",
    name = "radar-tracker",
    icon = "__Vehicle_Radar__/graphics/radar_technology.png",
    icon_size = 128,
    prerequisites = {"advanced-electronics"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "train-tracker"
      },
      {
        type = "unlock-recipe",
        recipe = "vehicular-tracker"
      },
    },
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 30
    },
    order = "c-g-c",
  },
})

