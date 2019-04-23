dc %>%
  leaflet() %>%
  addTiles %>%
  addCircleMarkers(data = dc, radius = .5)