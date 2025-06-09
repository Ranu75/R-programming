# Import data 
tf_train = BreastCancer
tf_test = BreastCancer

# Rename the target column
tf_train = tf_train %>%
  mutate(Class = if_else(Class == "benign", 1, 0))

tf_test = tf_test %>%
  mutate(Class = if_else(Class == "benign", 1, 0))

# Split data into two parts
X_train = as.matrix(tf_train[,2:10])
X_test = as.matrix(tf_test[,2:10])
y_train = as.matrix(tf_train[,11])
y_test = as.matrix(tf_test[,11])

# Cleaning matrix
## training
X_train = apply(X_train, 2, as.numeric)
X_train = as.matrix(X_train)
any(is.na(X_train)) # Checking missing value
X_train = X_train[complete.cases(X_train), ] # delete missing values

## test
X_test[is.na(X_test)] = 0 # mutate missing value by 0
X_test <- as.matrix(X_test)
storage.mode(X_test) = "numeric"  # au cas où certaines colonnes restent en mode "list" ou autre

dim(X_test)[1]
# Convert into categorical
Y_train = to_categorical(y_train,2)
Y_train <- Y_train[1:683, ] # must be dim(Y_train)[1] == dim(X_train)[1]

# Setting & Modeling
n_units = 512 

mod = keras_model_sequential()

mod = mod %>%
  layer_dense(units = n_units, input_shape = dim(X_train)[2]) %>%
  layer_activation_leaky_relu() %>%
  layer_dropout(rate = 0.25) %>%
  
  layer_dense(units = n_units) %>%
  layer_activation_leaky_relu() %>%
  layer_dropout(rate = 0.25) %>%
  
  layer_dense(units = n_units) %>%
  layer_activation_leaky_relu() %>%
  layer_dropout(rate = 0.25) %>%
  
  layer_dense(units = n_units) %>%
  layer_activation_leaky_relu() %>%
  layer_dropout(rate = 0.25) %>%
  
  layer_dense(units = n_units) %>%
  layer_activation_leaky_relu() %>%
  layer_dropout(rate = 0.25) %>%
  
  layer_dense(units = 2) %>%
  layer_activation("softmax")


mod %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_rmsprop(),
  metrics = c("accuracy")
)

mod %>%
  fit(X_train, Y_train, batch_size = 32, epochs = 15, verbose = 2, validation_split = 0.2)

#Validation
Y_test_hat = predict(mod, X_test) # prediction
Y_test_hat_class <- apply(Y_test_hat, 1, which.max) - 1 # convert into 
table(y_test, Y_test_hat_class)
print(c("Mean validation accuracy = ",mean(y_test == Y_test_hat_class)))











