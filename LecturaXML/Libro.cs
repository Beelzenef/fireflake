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
        ListaGeneros genero;

        public List<Personaje> listaPersonajes;
        List<Escena> listaEscenas;

        Personaje _protagonista;

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

        public ListaGeneros Genero
        {
            get { return genero; }
            set { genero = value; }
        }

        public Personaje Protagonista
        {
            get { return _protagonista; }
            set { _protagonista = value; }
        }

        #endregion

        #region Constructores

        public Libro()
        {
            listaEscenas = new List<Escena>();
            listaPersonajes = new List<Personaje>();
        }

        #endregion

        #region ListaGeneros

        public enum ListaGeneros
        {
            Fantasia,
            CienciaFiccion,
            Terror,
            Cyberpunk,
            Aventura, 
            Misterio
        }

        #endregion

        #region Gestion personajes

        /// <summary>
        /// Añadiendo personaje a la lista de personajes
        /// </summary>
        /// <param name="unPJ">Personaje a añadir</param>
        public void AnadirPersonaje(Personaje unPJ)
        {
            listaPersonajes.Add(unPJ);
        }

        /// <summary>
        /// Eliminar un personaje de la lista de personajes
        /// </summary>
        /// <param name="unPJ">Personaje a eliminar</param>
        public void EliminarPersonaje(Personaje unPJ)
        {
            listaPersonajes.Remove(unPJ);
        }

        #endregion

        #region Gestion de escenas

        /// <summary>
        /// Añadiendo escenas a la lista
        /// </summary>
        /// <param name="unaEscena">La escena a añadir</param>
        public void AnadirEscena(Escena unaEscena)
        {
            listaEscenas.Add(unaEscena);
        }

        /// <summary>
        /// Eliminación de una escena por identificador
        /// </summary>
        /// <param name="idEscena">Identificador de escena para su búsqueda</param>
        /// <returns>Devuelve T|F dependiendo de si el borrado ha tenido éxito o no</returns>
        public bool EliminarEscena(int idEscena)
        {
            for (int i = 0; i < listaEscenas.Count; i++)
            {
                if (listaEscenas[i].NumEscena == idEscena)
                {
                    listaEscenas.Remove(listaEscenas[i]);
                    return true;
                }
            }
            return false;
        }

        #endregion

        /// <summary>
        /// Añadiendo un protagonista al libro en cuestion
        /// </summary>
        /// <param name="prota">Protagonista creado</param>
        public void AnadirProtagonista(Personaje prota)
        {
            Protagonista = prota;
        }
    }
}
