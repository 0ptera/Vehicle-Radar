train_tracker = {
  energy_usage = 1000.0, -- kilo Watt
  refresh_time = 1.0, -- seconds
  scan_radius = 5, -- tiles, that are scanned around the train
  precognotion = 40.0, -- tiles
}

vehicle_tracker = {
  energy_usage = 1000.0, -- kilo Watt
  refresh_time = 8.0, -- seconds
  scan_radius = 5, -- tiles, that are scanned around the vehicle
  -- precognotion = 40.0, -- tiles --Vehicles don't scan ahead
}