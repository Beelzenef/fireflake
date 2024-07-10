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
            // Convirtiendo el fichero a XFFB
            string rutaXFFB = Path.ChangeExtension(ruta, ".xffb");

            XmlDocument escritor = new XmlDocument();

            // Declaracion de raíz del documento
            XmlDeclaration declaracion = escritor.CreateXmlDeclaration("1.0", "UTF-8", null);
            XmlElement raiz = escritor.DocumentElement;
            escritor.InsertBefore(declaracion, raiz);

            // Elemento libro
            XmlElement librete = escritor.CreateElement("libro");
            escritor.AppendChild(librete);
            // Elemento autor
            XmlNode autor = escritor.CreateElement("autor");
            autor.InnerText = unlibro.Autor;

            librete.AppendChild(autor);

            escritor.Save(rutaXFFB);

        }

        public static string AbrirXML(string ruta)
        {
            string cadenaPrueba;

            XmlDocument lector = new XmlDocument();
            lector.Load(ruta);

            XmlNode nodoAutor = lector.SelectSingleNode("/libro/autor");
            cadenaPrueba = nodoAutor.InnerText;

            return cadenaPrueba;
        }
        
    }
}
