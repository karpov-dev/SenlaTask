@IsTest
public class LeadDataFactory {

    public static Lead getLeadByName(String firstName, String lastName, String email) {
        return new Lead(FirstName = firstName, LastName = lastName, Phone = '123456789', Email = email, Company = 'Test Company');
    }
}