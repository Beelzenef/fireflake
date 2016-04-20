using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LecturaXML
{
    class Libro
    {

        #region Campo

        string autor;
        string titulo;
        string subtitulo;
        string genero;

        #endregion

        #region Propiedades

        public string Autor
        {
            get { return autor; }
            set { autor = value; }
        }

        public string Titulo
        {
            get { return titulo; }
            set { titulo = value; }
        }

        public string Subtitulo
        {
            get { return subtitulo; }
            set { subtitulo = value; }
        }

        public string Genero
        {
            get { return genero; }
            set { genero = value; }
        }

        #endregion

        #region Constructores

        public Libro(string titu, string subtit, string generrrro, string autorr)
        {
            this.Titulo = titu;
            this.Subtitulo = subtit;
            this.Genero = generrrro;
            this.Autor = autorr;
        }

        #endregion

    }
}
