# Run_Analysis.R
Takes .txt data from multiple files and combines the "mean" and "std" from each into a single clean data set
# You should include a README.md in the repo describing how the script works
The txt files are read from their separate files into data frames. The "features" table is cleaned 
and used as the column headers for the consolidated tables.  The individual tables created in the first step
are combined.  The columns that do not have "mean" or "std" in their name are stripped.  
Finally a separate table is created of the average values for all the columns.
