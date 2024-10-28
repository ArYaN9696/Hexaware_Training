namespace _28_10_assignment
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var studentService = new service(borrowable: new Student());
            studentService.BorrowBook("B001");

            var teacherService = new service(borrowable: new Teacher(), reservable: new Teacher());
            teacherService.BorrowBook("B002");
            teacherService.ReserveBook("B003");
            
            var librarianService = new service(manageable: new Librarian());
            librarianService.AddBook("B004");
            librarianService.RemoveBook("B005");
        }
    }
}
