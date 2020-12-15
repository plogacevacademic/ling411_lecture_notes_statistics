
cab_intercept <- 4.0
cab_slope_distance <- 2.5
cab_slope_nbridges <- 5
cab_slope_color_red <- 10
cab_slope_size_9seater <- 15
cab_slope_color_red_By_size_9seater <- 5
cab_bridge <- 10
cab_slope_npassengers <- 5

cab_slope_night <- 10
cab_slope_nightByDistance <- 1

rint_unif <- function(n, min, max) { 
  runif(n=n, min=min-0.499, max=max+0.499) %>% round() 
}

set.seed(1234)

n = 50000
cab_fares <- data.frame( distance_km = rint_unif(n, min=3, max=20),
                         n_bridges = rint_unif(n, min=0, max=10),
                         cab_color_red = runif(n=n, min=0, max=1) %>% round(),
                         cab_size_9seater =  runif(n=n, min=0, max=1) %>% round(),
                         n_passengers = rint_unif(n, min = 1, max = 4),
                         is_night = runif(n=n, min=0, max=1) %>% round()
)

n = 10
cab_fares %<>% rbind( 
  data.frame( distance_km = rint_unif(n, min=3, max=20),
              n_bridges = rep(0, n),
              cab_color_red = 0,
              cab_size_9seater = 0,
              n_passengers = 1,
              is_night = 0
  )
)

n = 30
cab_fares %<>% rbind( 
  data.frame( distance_km = rint_unif(n, min=3, max=20),
              n_bridges = rep(0, n),
              cab_color_red = c(0, 1),
              cab_size_9seater = 0,
              n_passengers = 1,
              is_night = 0
  )
)


#cars_perfect <- data.frame(speed = 1, weight = 1, distx = 1, dist = 1)

cab_fares <- within(cab_fares,
                    { fare_mnt <- cab_intercept + 
                      cab_slope_distance*distance_km + 
                      cab_slope_nbridges*n_bridges +
                      cab_slope_color_red*cab_color_red +
                      cab_slope_size_9seater*cab_size_9seater +
                      cab_slope_color_red_By_size_9seater*cab_color_red*cab_size_9seater +
                      cab_slope_npassengers * (n_passengers-1) +
                      cab_slope_night * is_night +
                      cab_slope_nightByDistance * is_night * distance_km
                    })

cab_fares1 <- cab_fares %>% subset(n_bridges == 0 &
                                     cab_color_red == 0 &
                                     cab_size_9seater == 0 &
                                     n_passengers == 1 &
                                     is_night == 0) %>% unique()
cab_fares2 <- cab_fares %>% subset(cab_color_red == 0 &
                                     cab_size_9seater == 0 &
                                     n_passengers == 1 & 
                                     is_night == 0) %>% unique()
cab_fares3 <- cab_fares %>% subset(distance_km == 10 &
                                     cab_size_9seater == 0 &
                                     n_bridges == 0 & 
                                     n_passengers == 1 & 
                                     is_night == 0) %>% unique()
cab_fares3B <- cab_fares %>% subset(distance_km == 10 &
                                      n_bridges == 0 & 
                                      n_passengers == 1 & 
                                      is_night == 0) %>% unique()
cab_fares4 <- cab_fares %>% subset(distance_km == 10 & 
                                     n_bridges == 0 &
                                     cab_color_red == 0 & #n_passengers == 1 &
                                     cab_size_9seater == 0 &
                                     is_night == 0) %>% unique()