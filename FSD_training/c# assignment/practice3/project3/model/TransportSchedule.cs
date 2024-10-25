using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace project3.model
{ 
        public class TransportSchedule
        {
            public string TransportType { get; set; } 
            public string Route { get; set; }
            public DateTime DepartureTime { get; set; }
            public DateTime ArrivalTime { get; set; }
            public decimal Price { get; set; }
            public int SeatsAvailable { get; set; }
        }
}



