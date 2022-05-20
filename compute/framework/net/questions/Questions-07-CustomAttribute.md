```csharp
[AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]  
public sealed class AccountBalaceCheckAttribute : ValidationAttribute  
{  
    protected override ValidationResult IsValid(object value, ValidationContext validationContext)  
    {  
        ValidationResult result = ValidationResult.Success;  
        string[] memberNames = new string[] { validationContext.MemberName };  

        decimal val = Convert.ToDecimal(value);  

        BankAccount account = (BankAccount)validationContext.ObjectInstance;  

        if (account.AcType == BankAccount.AccountType.Saving && val < 500)  
            result = new ValidationResult(string.Format(this.ErrorMessage, 500),memberNames);  
        else if (account.AcType == BankAccount.AccountType.Current && val < 1000)  
            result = new ValidationResult(string.Format(this.ErrorMessage, 1000), memberNames);  


        return result;  
    }  
}

public class BankAccount  
{  
  
   public enum AccountType  
   {  
      Saving,  
      Current  
   }  
  
   public AccountType AcType { get; set; }  
  
   [AccountBalaceCheckAttribute(ErrorMessage = "Account Balance should have value more than {0}")]  
   public double AccountBalance { get; set; }  
} 
```
