using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Xml;

namespace LecturaXML
{
    class GestionXML
    {

        static public void GuardarXML(string ruta, Libro unlibro)
        {
            using (XmlWriter escritor = XmlWriter.Create(ruta))
            {
                escritor.WriteStartDocument();
                escritor.WriteStartElement("libro");

                escritor.WriteElementString("titulo", unlibro.Titulo);
                escritor.WriteElementString("subtitulo", unlibro.Subtitulo);
                escritor.WriteElementString("autor", unlibro.Autor);
                escritor.WriteElementString("genero", unlibro.Genero);

                escritor.WriteEndElement();
                escritor.WriteEndDocument();
            }
        }

        public static void AbrirXML(string ruta)
        {
           
        }
        
    }
}
