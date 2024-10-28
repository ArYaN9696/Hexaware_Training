using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _28_10_assignment
{
    public class Student : IBorrowable
    {
        public void BorrowBook(string bookId)
        {
            Console.WriteLine($"Student borrowing book with ID: {bookId}");
        }
    }

    public class Teacher : IBorrowable, IReservable
    {
        public void BorrowBook(string bookId)
        {
            Console.WriteLine($"Teacher borrowing book with ID: {bookId}");
        }

        public void ReserveBook(string bookId)
        {
            Console.WriteLine($"Teacher reserving book with ID: {bookId}");
        }
    }

    public class Librarian : IManageable
    {
        public void AddBook(string bookId)
        {
            Console.WriteLine($"Librarian adding book with ID: {bookId}");
        }

        public void RemoveBook(string bookId)
        {
            Console.WriteLine($"Librarian removing book with ID: {bookId}");
        }
    }

}
