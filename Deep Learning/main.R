# import data
data("BreastCancer")

# exploring data
str(BreastCancer) # 11 features, 699 observations
colnames(BreastCancer) # list of column names

# cleaning data
## remove all lines with missing values
BreastCancer = BreastCancer %>%
  drop_na()

# preprocessing

## reorganize the column "Class"
BreastCancer = BreastCancer %>%
  mutate(class = if_else(Class=="benign", 0, 1)) %>%
  select(-Class)

## Split dataset into two parts
y = as.matrix(BreastCancer[,11])
X = BreastCancer[, 2:10] %>%
  as.matrix() %>%
  as.numeric() %>%
  matrix(ncol = 9)

# Modelling neural network with deepnet
nn = nn.train(X, y, hidden = c(5), learningrate = 1, momentum = 0.7)
nn.test(nn, X, y, t = 0.5)
yy = nn.predict(nn, X)

## Building estimator
yhat = matrix(0,length(yy),1)
yhat[which(yy > mean(yy))] = 1
yhat[which(yy <= mean(yy))] = 0

## Compute confusion matrix
confusion_matrix = table(y, yhat)

## Compute accuracy
print(sum(diag(confusion_matrix))/sum(confusion_matrix))

# Modelling neural network with neuralnet

## Building a dataframe
df = data.frame(cbind(X,y))
nn2 = neuralnet(X10~X1+X2+X3+X4+X5+X6+X7+X8+X9, df, 5)
yy2 = nn2$net.result[[1]]

yhat2 = matrix(0,length(yy2),1)
yhat2[which(yy2 > mean(yy2))] = 1
yhat2[which(yy2 <= mean(yy2))] = 0

## Compute confusion matrix
confusion_matrix2 = table(y, yhat2)

## Compute accuracy
print(sum(diag(confusion_matrix))/sum(confusion_matrix))

## plot the neural network scheme
plot(nn2)









