getData <- function(filename) {
  as.list(read.table(filename, header=TRUE, sep= ",", skipNul = TRUE))
}

basicSolD3 <- getData("Solutions/Basic Solutions/Solution_d3.csv")

#DIFFERENT POWER TYPES
basicCStaD3 <- basicSolD3[["Grid.Number"]]
res <- c()

ctcom <- c("HiHi", "HiMed", "HiLow", "MedLow", "MedMed", "MedHi", "LowLow", "LowMed", "LowHi")
for (i in 1:length(ctcom)) {
  data <- getData(paste("Solutions/Different Power/", ctcom[i], "_d3.csv", sep=""))
  CStaD3 <- data[["Grid.Number"]]
  
  #Agreeance with the basic data 
  ag <- CStaD3[CStaD3 %in% basicCStaD3]
  print(ag)
  res <- append(res, length(ag)/length(basicCStaD3))
}

plot(res)
m <- matrix(0, 3, 3)

m[1, 3] <- res[7]
m[2, 3] <- res[8]
m[3, 3] <- res[9]

m[1, 2] <- res[4]
m[2, 2] <- res[5]
m[3, 2] <- res[6]

m[1, 1] <- res[3]
m[2, 1] <- res[2]
m[3, 1] <- res[1]

print(res)
library(lattice)

levelplot(m, xlab="Fast Charger Power", ylab="Rapid Charger Power", scales=list(
        x=list(at=1:3,labels=c("Low", "Med", "High")),
        y=list(at=1:3,labels=c("Low", "Med", "High"))
),)


#SCALED DEMAND
basicCStaD3 <- basicSolD3[["Grid.Number"]]

res <- c()

demscale <- c("3", "4", "5", "6")
for (i in 1:length(demscale)) {
  data <- getData(paste("Solutions/Scaled Demand/Solution_", demscale[i], "half_times_demand.csv", sep=""))
  CSta <- data[["Grid.Number"]]
  
  #Agreeance with the basic data 
  ag <- CSta[CSta %in% basicCStaD3]
  res <- append(res, length(ag)/length(basicCStaD3))
}

plot(res, xlab="Scale of Demand Data 3", ylab="agreeance with basic solution", labels=FALSE)
axis(1, at=1:4, labels=c("1.5", "2", "2.5", "3"))
axis(2, at=res)

#Potential Discount

res <- c()

discount <- c()

for (i in 1:10) {
  discount <- append(discount, i*5)
}

for (i in 1:length(discount)) {
  data <- getData(paste("Solutions/Potential Discount/Solution_d3_", discount[i], "Discount.csv", sep=""))
  CSta <- data[["Grid.Number"]]
  
  #Agreeance with the basic data 
  ag <- CSta[CSta %in% basicCStaD3]
  res <- append(res, length(ag)/length(basicCStaD3))
}

plot(res, labels=FALSE, xlab = "Discount On Potential Charging Stations", ylab="Agreeance with Basic Results")
axis(1, at=1:10, labels=discount)
axis(2, at=res)

#FAST LOWER BOUND
#minimum requirement for fast chargers

res <- c()

p <- c()

for (i in 1:4) {
  p <- append(p, (i-1)*20)
}

for (i in 1:length(p)) {
  data <- getData(paste("Solutions/Fast Lower Bound/Solution_d3_", p[i], "Fast.csv", sep=""))
  CSta <- data[["Grid.Number"]]
  
  #Agreeance with the basic data 
  ag <- CSta[CSta %in% basicCStaD3]
  res <- append(res, length(ag)/length(basicCStaD3))
}

plot(res, labels=FALSE, xlab="Lower Bound on The Percentage Of Fast Charging Points", ylab="Agreeance With Basic Results")
axis(1, at=1:4, labels=p)
axis(2, at=res)

#Different levels for different fulfillment levels / lowered demand cases

res <- c()

p <- c()

for (i in 1:4) {
  p <- append(p, i*10+40)
}

for (i in 1:length(demscale)) {
  data <- getData(paste("Solutions/Fulfillment/Solution_d3_", p[i], "Fulfillment.csv", sep=""))
  CSta <- data[["Grid.Number"]]
  
  #Agreeance with the basic data 
  ag <- CSta[CSta %in% basicCStaD3]
  res <- append(res, length(ag)/length(basicCStaD3))
}

plot(res, labels=FALSE, xlab="% of demand to be fulfilled", ylab="Agreeance With Basic Results")
axis(1, at=1:4, labels=p)
axis(2, at=res)


data70 <- getData(paste("Solutions/Fulfillment/Solution_d3_70Fulfillment.csv", sep=""))
CSta70 <- data70[["Grid.Number"]]

data80 <- getData(paste("Solutions/Fulfillment/Solution_d3_80Fulfillment.csv", sep=""))
CSta80 <- data80[["Grid.Number"]]

#Agreeance with the basic data 
ag <- CSta70[CSta70 %in% CSta80]
q <- length(ag)/length(CSta80)
q


#ANALYSIS OF BASIC RESULTS

basicSolD3 <- getData("Solutions/Basic Solutions/Solution_d3.csv")
basicSolD2 <- getData("Solutions/Basic Solutions/Solution_d2.csv")
basicSolD1 <- getData("Solutions/Basic Solutions/Solution_d1.csv")
basicSolD0 <- getData("Solutions/Basic Solutions/Solution_d0.csv")

basicCStaD3 <- basicSolD3[["Grid.Number"]]
basicCStaD2 <- basicSolD2[["Grid.Number"]]
basicCStaD1 <- basicSolD1[["Grid.Number"]]
basicCStaD0 <- basicSolD0[["Grid.Number"]]

ag01 <- basicCStaD0[basicCStaD0 %in% basicCStaD1]
v01 <- length(ag01)/length(basicCStaD1)

ag12 <- basicCStaD1[basicCStaD1 %in% basicCStaD2]
v12 <- length(ag12)/length(basicCStaD2)

ag23 <- basicCStaD2[basicCStaD2 %in% basicCStaD3]
v23 <- length(ag23)/length(basicCStaD3)

ag13 <- basicCStaD2[basicCStaD1 %in% basicCStaD3]
v13 <- length(ag13)/length(basicCStaD3)

ag123 <- ag12[ag12 %in% basicCStaD3]
v123 <- length(ag123)/length(basicCStaD3)

ag0 <- ag123[basicCStaD0 %in% ag123]


plot(c(v01, v12, v23, v13, v123), labels=FALSE, xlab="A:B = Comparison of Demand A with Demand B", ylab="Agreeance")
axis(1, at=1:5, label=c("0:1", "1:2", "2:3", "1:3", "1:2:3"))
axis(2, at=c(v01, v12, v23, v13, v123))

print(ag12)
print(ag23)
print(ag13)
print(ag123)


basic <- 





