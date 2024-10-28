using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _28_10_assignment
{
    public class service
    {
        private readonly IBorrowable _borrowable;
        private readonly IReservable _reservable;
        private readonly IManageable _manageable;

        public service(IBorrowable borrowable = null, IReservable reservable = null, IManageable manageable = null)
        {
            _borrowable = borrowable;
            _reservable = reservable;
            _manageable = manageable;
        }

        public void BorrowBook(string bookId)
        {
            _borrowable?.BorrowBook(bookId);
        }

        public void ReserveBook(string bookId)
        {
            _reservable?.ReserveBook(bookId);
        }

        public void AddBook(string bookId)
        {
            _manageable?.AddBook(bookId);
        }

        public void RemoveBook(string bookId)
        {
            _manageable?.RemoveBook(bookId);
        }
    }
}
