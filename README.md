Project Name
makra
V 1.0


Description

Features
- Can fetch emails from any text format which is not encrypted, filesize max = 1GB
- From fetched email list can auto remove emails which are fake or doesn't make sense using AI i.e rbe.names file provided.
- Capable to realtime validate email address by communicating via MTAs, except outlook emails.
- Able to segregate emails based on the industry. For example the scripts auto segregate the all valid emails for "leather bags industry" and then again
segregate them based on the company name and then export it to a csv which can be processed easily in all major databases.
- Able to validate the emails for multiple files in single script.
- Scripts are designed deliberately with a delay to not overload the MTAs servers.

Installation
- the "file" contains the list of csv files which has just one column with emails in it i.e a.csv, b.csv, c.csv etc.
- cleaner.sh first checks all files queued in "file" and removes general and fake emails from the csv files.
- scripts are case sensetive for emails. Hence, "captolower_duplicate_remover.sh" makes sure all is good.
- "addr_extender.sh" is optional unless you want to segregate individual emails and company emails listed separately.
- Untill now it was all to make the data in the format so we could easily process for validation.
- "valid_extractor.sh" is the main script which connect with MTAs online and checks for each email one by one and makes sure if it's valid email
and it does really exist on the target domain email server.
- Finally it outputs all the data to csv files with their initial names i.e a_VALID.csv, b_VALID.csv, c_VALID.csv.


Clone the repository: git clone [https://github.com/manoonabbasi/makra]
Install dependencies: none

Contributors
M Mansoor Ahmed

License
GNU, GPL







