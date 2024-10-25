using project1.Model;
using project1.Repository;

namespace project1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var authors = new List<Author>
            {
                new Author { Id = 1, Name = "Author One", Nationality = "American", DateOfBirth = new DateTime(1960, 1, 1) },
                new Author { Id = 2, Name = "Author Two", Nationality = "British", DateOfBirth = new DateTime(1970, 2, 15) },
                new Author { Id = 3, Name = "Author Three", Nationality = "Canadian", DateOfBirth = new DateTime(1980, 3, 25) },
                new Author { Id = 4, Name = "Author Four", Nationality = "Indian", DateOfBirth = new DateTime(1990, 4, 10) },
                new Author { Id = 5, Name = "Author Five", Nationality = "Australian", DateOfBirth = new DateTime(1985, 5, 20) }
            };

            var books = new List<Book>
            {
                new Book { Id = 1, Title = "Book One", AuthorId = 1, Price = 19.99, YearPublished = 2001 },
                new Book { Id = 2, Title = "Book Two", AuthorId = 2, Price = 15.99, YearPublished = 2005 },
                new Book { Id = 3, Title = "Book Three", AuthorId = 3, Price = 25.99, YearPublished = 2010 },
                new Book { Id = 4, Title = "Book Four", AuthorId = 4, Price = 10.99, YearPublished = 2015 },
                new Book { Id = 5, Title = "Book Five", AuthorId = 5, Price = 18.99, YearPublished = 2020 }
            };

            // Save data to JSON and XML
            FileHandler<Author>.SaveToJson(authors, "Authors.json");
            FileHandler<Author>.SaveToXml(authors, "Authors.xml");
            FileHandler<Book>.SaveToJson(books, "Books.json");
            FileHandler<Book>.SaveToXml(books, "Books.xml");

            // Load and display data from JSON
            Console.WriteLine("Authors from JSON:");
            var jsonAuthors = FileHandler<Author>.LoadFromJson("Authors.json");
            jsonAuthors.ForEach(author => Console.WriteLine($"{author.Name}, {author.Nationality}, {author.DateOfBirth.ToShortDateString()}"));

            Console.WriteLine("\nBooks from JSON:");
            var jsonBooks = FileHandler<Book>.LoadFromJson("Books.json");
            jsonBooks.ForEach(book => Console.WriteLine($"{book.Title}, ${book.Price}, Year Published: {book.YearPublished}"));

            // Load and display data from XML
            Console.WriteLine("\nAuthors from XML:");
            var xmlAuthors = FileHandler<Author>.LoadFromXml("Authors.xml");
            xmlAuthors.ForEach(author => Console.WriteLine($"{author.Name}, {author.Nationality}, {author.DateOfBirth.ToShortDateString()}"));

            Console.WriteLine("\nBooks from XML:");
            var xmlBooks = FileHandler<Book>.LoadFromXml("Books.xml");
            xmlBooks.ForEach(book => Console.WriteLine($"{book.Title}, ${book.Price}, Year Published: {book.YearPublished}"));
        }
    }
    }

