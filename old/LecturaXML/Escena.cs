using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LecturaXML
{
    public class Escena
    {

        #region Campos

        private int numEscena;
        private string pov;
        private string capitulo;
        private string resumenEscena;

        #endregion

        #region Propiedades

        public int NumEscena
        {
            get
            {
                return numEscena;
            }

            set
            {
                numEscena = value;
            }
        }

        public string PoV
        {
            get
            {
                return pov;
            }

            set
            {
                pov = value;
            }
        }

        public string ResumenEscena
        {
            get
            {
                return resumenEscena;
            }

            set
            {
                resumenEscena = value;
            }
        }

        public string Capitulo
        {
            get
            {
                return capitulo;
            }

            set
            {
                capitulo = value;
            }
        }
        #endregion

        #region Constructores

        #endregion

        #region Metodos

        #endregion
    }


}