# Data Warehousing and vizualisation
    In this project I tried to use all the technologies I have learned in my first year of Masters in data 
    warehousing and vizualisation. 
    The project contains two major steps:
        * The design and creation of a data Warehouse (Star schema and ETL)
        * The combination of the data in the datasets before putting them together in a PDF report

## Step 1 : Data Warehousing
### Talend Studio 
    In this section I combined all the data sources to create a proper metadata using oracle
    and sqlite database connections as well as an XML file, and a CSV file.
![MetaData](./Capture%20job%20talend/Metadata.png)
#### Model Design
    In this part I used 'Bimodeler' to design the dimension and the relational models.
###
-> Relational model
![Relationel](./Model_relationnel.png)

-> Dimensional model 
![Dim](./Modele_Dimensionnel.png)

#### Model Creation
    As demonstrated in the file shéma_étoil.sql, I created the schema in Oracle-Sqldev 
    using a virtual machine.

#### Jobs Creation 
    In each job I created a metadata input, an oracle output, and a log object to view my 
    fields on the console.
    Here are some different job examples for you:

----> Client Job

    This job combined an CSV file and an Sqlite table to a MAP in order to push them in 
    the oracle table.
![Client](./Capture%20job%20talend/Client.png)

----> Commerciaux Job
    
    This is a XML to Oracle Job.
![Commerciaux](./Capture%20job%20talend/Commerciaux.png)

----> Periode Job
    
    This is a Sqlite to Oracle Job.
![Period](./Capture%20job%20talend/Periode.png)

## Step 2 : Data Vizualisation (Reporting)
### Eclipse Birt
    Once I finished the Data warehousing, I moved to 'Birt' in order to create an 
    example of a data vizualisation report as shown in the folder:
    Reporting/Exemple_rapport.pdf.

#### Data Source : 
    In this section I made sure to create a new datasource and connect it with the Oracle
    data warehouse running on the current PORT.

#### Data set :
    This section used the previous data source which was connected to the data warehouse 
    and used SQL requests to answer the client's specifications. 
    All the possible answers to the specifications are in the Reporting/Requete.sql file.

#### Concrete example
    This is a preview on how to create a dataset and showcase it properly: 
----> Data set creation : ( Total turnover by product filtred by categorie )
#####
I created a view that selects annuel turnovers of product filtred by categories: 
![View_princ](./Reporting/View.png)
####
I then created a dataset that selects from this view with a 'total' condition:
![View_princ](./Reporting/dataset.png)

----> Chart Creation and vizualisation : 

    Once the datasets are ready, chose from 'Birt' charts any type desired.

![Chart](./Reporting/chart.png)
    
    You can see the full report on the repository, and if you made it this far 
    thank you for reading this 💖


    






        
