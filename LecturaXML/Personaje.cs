using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LecturaXML
{
    public class Personaje
    {
        #region Campos
        private string nombre;
        private string historia;
        private string motivaciones;
        private string objetivo;
        private string epifania;
        private string conflicto;
        #endregion


        #region Propiedades

        public string Nombre
        {
            get
            {
                return nombre;
            }

            set
            {
                nombre = value;
            }
        }

        public string Historia
        {
            get
            {
                return historia;
            }

            set
            {
                historia = value;
            }
        }

        public string Motivaciones
        {
            get
            {
                return motivaciones;
            }

            set
            {
                motivaciones = value;
            }
        }

        public string Objetivo
        {
            get
            {
                return objetivo;
            }

            set
            {
                objetivo = value;
            }
        }

        public string Conflicto
        {
            get
            {
                return conflicto;
            }

            set
            {
                conflicto = value;
            }
        }

        public string Epifania
        {
            get
            {
                return epifania;
            }

            set
            {
                epifania = value;
            }
        }

        #endregion

        #region Constructor

        public Personaje(string nomb, string hist, string motiv, string objetv, string epif, string conflict)
        {
            Nombre = nomb;
            Historia = hist;
            Motivaciones = motiv;
            Objetivo = objetv;
            Epifania = epif;
            Conflicto = conflict;
        }

        #endregion
    }
}