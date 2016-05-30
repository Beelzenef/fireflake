using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LecturaXML
{
    class Libro
    {

        #region Campos

        string autor;
        string titulo;
        string subtitulo;
        string genero;

        public List<Personaje> listaPersonajes;
        List<Escena> listaEscenas;

        Personaje Protagonista;

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
            Titulo = titu;
            Subtitulo = subtit;
            Genero = generrrro;
            Autor = autorr;
            listaPersonajes = new List<Personaje>();
            listaEscenas = new List<Escena>();
        }

        #endregion

        public void AnadirPersonaje(Personaje unPJ)
        {
            listaPersonajes.Add(unPJ);
        }

        public void AnadirEscena(Escena unaEscena)
        {
            listaEscenas.Add(unaEscena);
        }

        public void AnadirProtagonista(Personaje prota)
        {
            Protagonista = prota;
        }
    }
}
