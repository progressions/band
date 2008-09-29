load data local infile 'fans.csv' into table fans
fields terminated by ','
lines terminated by '\n'
(FirstName, LastName, Email, ZipCode)