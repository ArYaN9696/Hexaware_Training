using project2.Model;

namespace project2
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var customer = new Customer();

            // Take Name input
            Console.Write("Enter Name: ");
            customer.Name = Console.ReadLine();

            // Take Email input and validate
            Console.Write("Enter Email: ");
            customer.Email = Console.ReadLine();
            bool isEmailValid =Validator.ValidateEmail(customer.Email);
            Console.WriteLine(isEmailValid ? "Email is valid." : "Email is invalid.");

            // Take Phone Number input and validate
            Console.Write("Enter Phone Number (10 digits): ");
            customer.PhoneNumber = Console.ReadLine();
            bool isPhoneNumberValid = Validator.ValidatePhoneNumber(customer.PhoneNumber);
            Console.WriteLine(isPhoneNumberValid ? "Phone Number is valid." : "Phone Number is invalid.");

            // Take Date of Birth input and validate
            Console.Write("Enter Date of Birth (YYYY-MM-DD): ");
            if (DateTime.TryParse(Console.ReadLine(), out DateTime dob))
            {
                customer.DateOfBirth = dob;
                bool isDobValid = Validator.ValidateDateOfBirth(customer.DateOfBirth);
                Console.WriteLine(isDobValid ? "Date of Birth is valid." : "Date of Birth is invalid (Must be 18 years or older).");
            }
            else
            {
                Console.WriteLine("Invalid Date format.");
            }
        }
    }
    
}
