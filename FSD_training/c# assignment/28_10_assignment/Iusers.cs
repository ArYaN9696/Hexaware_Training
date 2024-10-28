using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _28_10_assignment
{
    // Operations related to borrowing, reserving, and managing books
    public interface IBorrowable
    {
        void BorrowBook(string bookId);
    }

    public interface IReservable
    {
        void ReserveBook(string bookId);
    }

    public interface IManageable
    {
        void AddBook(string bookId);
        void RemoveBook(string bookId);
    }

}
