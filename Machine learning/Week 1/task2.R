createRandomPointsWithErrorsForTargetFunction = function(numberOfPoints, interval) {
  x = runif(numberOfPoints, interval[1], interval[2])
  y = 2 + x - 0.5 * x ^ 2
  errors = rnorm(n = numberOfPoints, mean = 0, sd = 0.4)
  ywitherrors = y + errors # adding errors to the function values
  
  return(matrix(c(x, ywitherrors),ncol = 2, nrow = length(x)))
}

mse = function(points, func, numbers) {
  #return(sum((points - func) ^ 2) / numbers)
  return(mean((points - func) ^ 2))
} 

# configuration
set.seed(20)
degree = 8
interval = c(-3, 3)
points = 30

points = createRandomPointsWithErrorsForTargetFunction(numberOfPoints = points, interval)
x = points[,1]
y = points[,2]
plot(x, y, pch=16) 

# creating model with the give degree
regression = lm(y ~ poly(x, degree))
values = seq(from = interval[1], to = interval[2], by = 0.1)
model = predict(regression, data.frame(x = values), interval = "confidence", level = 0.95)

# adding mode to the plot
lines(values, model[,1], col='green', lwd=5)

mse_value = mean(regression$residuals^2)
sprintf("MSE: %f", mse_value)

# task 2
points = 1000

values = createRandomPointsWithErrorsForTargetFunction(numberOfPoints = points, interval)
x = values[,1]
y = values[,2]

points(x = x, y = y, col="red")

values = seq(interval[1], interval[2], length.out = number)
newprediction = predict(regression, data.frame(x = values), interval = "confidence", level = 0.95)

new_mse_value = mse(points = newprediction[,1], func = y, numbers = points)
sprintf("MSE: %f", new_mse_value)
