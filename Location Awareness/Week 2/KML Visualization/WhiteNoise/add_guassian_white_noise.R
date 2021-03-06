coordinates = read.csv("tokyo-lon-lat.csv",header = FALSE, sep = ",")

par(mfrow=c(1, 2))
plot(coordinates, xlab = "Latitude", ylab = "Longitute")

variance = 0.075
noise = matrix(rnorm(n = 100, mean = 0, sd = variance ^ 2), ncol = 2)

newPoints = coordinates + noise 

plot(coordinates, xlab = "Latitude", ylab = "Longitute")
points(newPoints, col="red")