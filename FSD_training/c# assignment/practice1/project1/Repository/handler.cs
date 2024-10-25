using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace project1.Repository
{
    public static class FileHandler<T> where T : class
    {
        public static void SaveToJson(List<T> data, string fileName)
        {
            using (FileStream fs = new FileStream(fileName, FileMode.Create))
            {
                JsonSerializer.Serialize(fs, data);
            }
        }

        public static List<T> LoadFromJson(string fileName)
        {
            using (FileStream fs = new FileStream(fileName, FileMode.Open))
            {
                return JsonSerializer.Deserialize<List<T>>(fs);
            }
        }

        public static void SaveToXml(List<T> data, string fileName)
        {
            using (FileStream fs = new FileStream(fileName, FileMode.Create))
            {
                var serializer = new XmlSerializer(typeof(List<T>));
                serializer.Serialize(fs, data);
            }
        }

        public static List<T> LoadFromXml(string fileName)
        {
            using (FileStream fs = new FileStream(fileName, FileMode.Open))
            {
                var serializer = new XmlSerializer(typeof(List<T>));
                return (List<T>)serializer.Deserialize(fs);
            }
        }

    }
}
