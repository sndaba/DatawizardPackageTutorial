#Installing and loading the Datawizard package
install.packages("datawizard")
library(datawizard)

#read the dataset using the data_read() function
house_price <- data_read("https://raw.githubusercontent.com/sndaba/RPackagesForDataCleaning/main/NYC_2022.csv")
View(house_price)

#data_peek shows a summary of the each variables' details
data_peek(house_price)

#generate an overview of statistics of missing, number of values, frequency of a value
(code <- data_codebook(house_price))

#missing data for numeric and characters
house_price_missing <- house_price <- convert_na_to(house_price, replace_num = 0, replace_char = "missing")

#finding columns
find_columns(house_price_missing, starts_with("neighbourhood"))

#output shows columns at the bottom
#[1] "neighbourhood_group" "neighbourhood"

#get_columns()
get_columns(house_price_missing, starts_with("neighbourhood"))

#looks for columns even with a typo. "hot" is similar to "host" or "hood"
data_seek(house_price, "hot", fuzzy = TRUE)

#remove data.frame,column
house_price <- datawizard::data_remove(house_price, "latitude", "longitude") 

#remove data.frame,column
house_price <- datawizard::data_remove(house_price,"id")    

#add the names of the cols in the new order
house_price <- house_price_missing <- datawizard::data_reorder(house_price,c("host_id","name")) 

#add the names of the cols in the new order
house_price <- datawizard::data_reorder(house_price,c("host_name","name"))

#add the names of the cols in the new order
house_price <- datawizard::data_reorder(house_price,c("host_id","host_name"))

#the column "price" will change to "house_price"
house_price <- datawizard::data_rename(house_price,"price","house_price")

#match rows following variable conditions with data_match()
View(data_match(house_price, data.frame(neighbourhood_group = "Brooklyn")))

#filtering using logical expressions
View(data_filter(house_price, room_type == "Private room" & house_price > 120000))



