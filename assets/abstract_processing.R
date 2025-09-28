# Function to programmatically turn abstracts in table into single quarto markdown documents for listings page 

# import abstract data from GoogleSheets and clean-up table

library(googlesheets4)

date <- "2025" # year of workshop
location <- "Budapest" # Location of workshop

data <- read_sheet("1Yz18tbx8ZIVPMRdXqlD3ljjKgGQcfAfokckkDIPQBHM", range = "A:BO", col_types = "c")

data <- subset(
  data, select = c(
    "Running_order",
    "Email Address", 
    "Title of abstract", 
    "Keywords", 
    "Abstract", 
    grep("^First", names(data), value = TRUE), 
    grep("^Affiliation", names(data), value = TRUE), 
    grep("^ORCID", names(data), value = TRUE), 
    grep("^Institution", names(data), value = TRUE)
  )
)

names(data) <- c("Running_order", "Mail", "Title", "Keywords", "Abstract", paste0("Author_", 1:11), paste0("Affiliation_", 1:11), paste0("ORCID_", 1:11), paste0("Institution_", 1:9))

data$Keywords <- gsub(";", ",", data$Keywords)

# create article

for (i in 1:nrow(data)) {
  
  cat(
    '---', 
    paste0("title: '", data$Title[i], "'"), 
    paste0('date: "', date, '"'), 
    'date-format: "YYYY"',
    'Event: Workshop',
    paste0('categories: [', data$Keywords[i], ']'), 
    
    # Author 1
    'author: ',
    paste0('  - name: ', data$Author_1[i]), 
    if (!is.na(data$ORCID_1[i])) {paste0('    orcid: ', data$ORCID_1[i])},
    '    corresponding: true', 
    paste0('    email: ', data$Mail[i]), 
    
    # Author 2
    if (!is.na(data$Author_2[i])) {paste0('  - name: ', data$Author_2[i])},
    if (!is.na(data$ORCID_2[i])) {paste0('    orcid: ', data$ORCID_2[i])}, 
    
    # Author 3
    if (!is.na(data$Author_3[i])) {paste0('  - name: ', data$Author_3[i])},
    if (!is.na(data$ORCID_3[i])) {paste0('    orcid: ', data$ORCID_3[i])}, 
    
    # Author 4
    if (!is.na(data$Author_4[i])) {paste0('  - name: ', data$Author_4[i])},
    if (!is.na(data$ORCID_4[i])) {paste0('    orcid: ', data$ORCID_4[i])}, 
    
    # Author 5
    if (!is.na(data$Author_5[i])) {paste0('  - name: ', data$Author_5[i])},
    if (!is.na(data$ORCID_5[i])) {paste0('    orcid: ', data$ORCID_5[i])}, 
    
    # Author 6
    if (!is.na(data$Author_6[i])) {paste0('  - name: ', data$Author_6[i])},
    if (!is.na(data$ORCID_6[i])) {paste0('    orcid: ', data$ORCID_6[i])}, 
    
    # Author 7
    if (!is.na(data$Author_7[i])) {paste0('  - name: ', data$Author_7[i])},
    if (!is.na(data$ORCID_7[i])) {paste0('    orcid: ', data$ORCID_7[i])}, 
    
    # Author 8
    if (!is.na(data$Author_8[i])) {paste0('  - name: ', data$Author_8[i])},
    if (!is.na(data$ORCID_8[i])) {paste0('    orcid: ', data$ORCID_8[i])}, 
    
    # Author 9
    if (!is.na(data$Author_9[i])) {paste0('  - name: ', data$Author_9[i])},
    if (!is.na(data$ORCID_9[i])) {paste0('    orcid: ', data$ORCID_9[i])}, 
    
    # Author 10
    if (!is.na(data$Author_10[i])) {paste0('  - name: ', data$Author_10[i])},
    if (!is.na(data$ORCID_10[i])) {paste0('    orcid: ', data$ORCID_10[i])}, 
    
    # Author 1
    if (!is.na(data$Author_11[i])) {paste0('  - name: ', data$Author_11[i])},
    if (!is.na(data$ORCID_11[i])) {paste0('    orcid: ', data$ORCID_11[i])}, 
    
    '---', 
    '',
    paste0('*This paper was presented at the YRA Workshop ', date, ' in ', location, '.*'), 
    '',   
    data$Abstract[i], 
    '', 
    '[![CC-BY 4.0 icon](https://i.creativecommons.org/l/by/4.0/88x31.png)](http://creativecommons.org/licenses/by/4.0/)&nbsp;&nbsp; This work is licensed under a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/). ',
    sep = "\n", 
    file = paste0('abstracts/', date, "-", data$Running_order[i], '.qmd')
  )
}

