
The dependency free package of dplyr that is lighteight and has a different way of naming its functions with `data_` before the fucntion name.
The full article can be found on medium. 

![logo](https://github.com/sndaba/DatawizardTutorial/assets/53818579/6c03c0cf-5fc0-401b-8494-a4d95abea4c5)

I discovered Datawizard when researching for my talk on R packages for data cleaning. The latest version of Datawizard 0.9.1 was released on the 9th of September 2023.
Datawizard is used for data transformation and statistic operations and is also part of the [easystats](https://easystats.github.io/easystats/) collection.

This is a short tutorial on functions from the Data wizard package for data wrangling by using a dataset that can show us how the functions work.

## 1.  Installing the Datawizard package
Installing and loading the Datawizard package.
```
install.packages("datawizard")
library(datawizard)
```

## 2. Read the dataset using `data_read()`
The `data_read()` function imports data from various file types. 
It is a small wrapper around haven::read_stata(), readxl::read_excel() and data.table::fread() .
```
#read the dataset using the data_read() function
house_price <- data_read("https://raw.githubusercontent.com/sndaba/RPackagesForDataCleaning/main/NYC_2022.csv")
View(house_price)

#output dataset sample seen below
```
![image](https://github.com/sndaba/DatawizardTutorial/assets/53818579/aa0faae7-ee55-4811-ba98-96e5f07f87e3)

sample of the dataset

## 3.Peek at the values and type of variables using `data_peek()`

The function creates a table data frame, showing all column names, variable types and the first values (as many as fit into the screen).
```
#data_peek shows a summary of the each variables' details
data_peek(house_price)
```
![image](https://github.com/sndaba/DatawizardTutorial/assets/53818579/57d7f817-432a-408d-a292-91a5db900f46)

data frame summary showing the type of each variable and examples of values in a variable

## 4. Statistical summary using `data_codebook()`

`data_codebook()` generates codebooks from data frames, i.e. overviews of all variables and some more information about each variable (like labels, values or value range, frequencies, amount of missing values).

```
#generate an overview of statistics of missing, number of values, frequency of a value
(code <- data_codebook(house_price))
```
![image](https://github.com/sndaba/DatawizardTutorial/assets/53818579/0eb7e12e-54d7-4df4-82af-3eea978a71e2)

Output from `codebook()`

## 5. Replacing missing values with `convert_na_to()`

Replace missing values in a variable or a data frame using `convert_na_to()`.
```
#missing data for numeric and characters
house_price_missing <- house_price <- convert_na_to(house_price, replace_num = 0, replace_char = "missing")
```

## 6. Searching for columns

`find_columns()` returns column names from a data set that match a certain search pattern, while `get_columns()` returns the found data.
```
#finding columns
find_columns(house_price_missing, starts_with("neighbourhood"))

#output shows columns at the bottom
[1] "neighbourhood_group" "neighbourhood"
```

```
#get_columns()
get_columns(house_price_missing, starts_with("neighbourhood"))
```
![image](https://github.com/sndaba/DatawizardTutorial/assets/53818579/f0b91595-00e5-42c5-83d1-2b88dc8370ab)

`get_columns()` output shows values of the columns

## 7. Look for columns based on pattern name with `data_seek()`

The `data_seek()` looks for variables in a data frame, based on patterns that either match the variable name (column name), variable labels, value labels or factor levels. Matching variable and value labels only works for “labelled” data, i.e. when the variables either have a label attribute or labels attribute.

```
#looks for columns even with a typo. "hot" is similar to "host" or "hood"
data_seek(house_price, "hot", fuzzy = TRUE)
```
![image](https://github.com/sndaba/DatawizardTutorial/assets/53818579/2ebb144f-6740-4f3e-8a3d-72ed92cbfd0a)

list of columns that a close to the label “hot”

## 8. Remove columns with `data_remove()`

The `data_remove()` removes columns from a data frame. All functions support select-helpers that allow flexible specification of a search pattern to find matching columns, which should be reordered or removed.
```
#remove data.frame,column
house_price <- datawizard::data_remove(house_price, "latitude", "longitude") 
```

```
#remove data.frame,column
house_price <- datawizard::data_remove(house_price,"id")    
```


## 9. Column reordering with `data_reorder()`

The `data_reorder()` will move selected columns to the beginning of a data frame. The other column ordering function, data_relocate() (not covered in this article), will reorder columns to specific positions, indicated by before or after.

```
#add the names of the cols in the new order
house_price <- house_price_missing <- datawizard::data_reorder(house_price,c("host_id","name")) 
```

```
#add the names of the cols in the new order
house_price <- datawizard::data_reorder(house_price,c("host_name","name"))
```

```
#add the names of the cols in the new order
house_price <- datawizard::data_reorder(house_price,c("host_id","host_name"))
```
![image](https://github.com/sndaba/DatawizardTutorial/assets/53818579/e876d91e-ddea-414d-a8e6-b323e0468559)

columns reordered

## 10. Rename some columns using `data_rename()`

```
#the column "price" will change to "house_price"
house_price <- datawizard::data_rename(house_price,"price","house_price")
```

## 11. Filtering and Matching with `data_filter()` and `data_match()`

Both functions return a filtered (or sliced) data frame or row indices of a data frame that match a specific condition. `data_filter()` works like `data_match()`, but works with logical expressions or row indices of a data frame to specify matching conditions.

```
#match rows following variable conditions with data_match()
View(data_match(house_price, data.frame(neighbourhood_group = "Brooklyn")))
```
![image](https://github.com/sndaba/DatawizardTutorial/assets/53818579/5d009ae5-63b8-4c97-a555-59836c496475)

data frame subset with rows relating to neighbourhood_group column set to “Brooklyn”. 

```
#filtering using logical expressions
View(data_filter(house_price, room_type == "Private room" & house_price > 120000))
```
![image](https://github.com/sndaba/DatawizardTutorial/assets/53818579/e21dddf9-01fa-4702-8d54-073ef080b030)

data frame subset with room_type set to “Private room” and house_price > 120000. Photo by Author.

#In Summary
The Datawizard package is an all purpose Data Science package where you can get operations for data formation, statistical summaries and data cleaning.

Further reading on Datawizard and coding at [Datawizard repository]https://github.com/easystats/datawizard.


