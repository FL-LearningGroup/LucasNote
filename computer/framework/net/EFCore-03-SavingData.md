## Question01: Workflow of SavingData operation
Each context instance has a ChangeTracker that is reponsible for keeping track of changes that need to be written to the database.  
As you make changes to instances of your entity classes, these changes are recorded in the ChangeTracker and the written to teh database when your call SaveChanges.
