using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LecturaXML
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        #region Menu principal

        Libro lib1 = null;
        bool guardado = true;
        string ruta = string.Empty;

        private void guardarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            lib1 = new Libro(txtB_Titulo.Text, txtB_Subtitulo.Text, txtB_Genero.Text, txtB_Autor.Text);
            GestionXML.GuardarXML(ruta, lib1);
            guardado = true;
        }

        private void guardarComoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (sFD_GuardarXML.ShowDialog() != DialogResult.OK)
                return;
            ruta = sFD_GuardarXML.FileName;
            lib1 = new Libro(txtB_Titulo.Text, txtB_Subtitulo.Text, txtB_Genero.Text, txtB_Autor.Text);
            GestionXML.GuardarXML(ruta, lib1);
            guardado = true;
        }

        private void abrirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (oFD_AbrirXML.ShowDialog() != DialogResult.OK)
                return;
            ruta = oFD_AbrirXML.FileName;
            dataSetXML.ReadXml(ruta);
            dataGV_Escenas.DataSource = dataSetXML;
            dataGV_Escenas.DataMember = "escena";
        }

        #endregion

        #region Cierre de programa

        private void CerrandoApp(object sender, FormClosingEventArgs e)
        {
            DialogResult confirmarGuardarSalir;

            MessageBoxButtons btns = MessageBoxButtons.YesNo;
            string cadenaSalida = "Saliendo del programa";

            if (!guardado)
            {
                confirmarGuardarSalir = MessageBox.Show("¡Fichero no guardado!, ¿quieres guardar?", cadenaSalida, btns);
                if (confirmarGuardarSalir == DialogResult.Yes)
                {
                    GestionXML.GuardarXML(ruta, lib1);
                }
            }

        }

        #endregion

        #region Cambio de datos
        private void DatosCambiados(object sender, EventArgs e)
        {
            guardado = false;
        }

        private void CambioFilas(object sender, DataGridViewRowsAddedEventArgs e)
        {
            // Cuando se modifican datos a mano, no cuando Abrir: guardado = false;
        }

        private void CambioCelda(object sender, DataGridViewCellEventArgs e)
        {
            // Cuando se modifican datos a mano, no cuando Abrir: guardado = false;
        }
        #endregion

        #region Gestionando DGV

        private void EliminarFila(object sender, EventArgs e)
        {
            try
            {
                dataGV_Escenas.Rows.RemoveAt(dataGV_Escenas.CurrentCell.RowIndex);

            }
            catch
            {
                MessageBox.Show("¡No hay más filas que eliminar!");
            }
        }



        #endregion

        #region Gestion de nuevo libro

        Libro libro;

        private void btn_NuevoLibro_Click(object sender, EventArgs e)
        {
            libro = new Libro(txtB_Titulo.Text, txtB_Subtitulo.Text, txtB_Genero.Text, txtB_Autor.Text);
            btn_AnadirPersonaje.Enabled = true;
        } 
        #endregion

        #region Gestionando lista de personajes

        private void AnadirPersonaje_Click(object sender, EventArgs e)
        {
            if (lsB_ListaPJs.SelectedIndex == lsB_ListaPJs.Items.Count - 1)
            {
                Personaje pj = new Personaje(
                    txtB_NombrePJ.Text,
                    txtB_HistoriaPJ.Text,
                    txtB_MotivPJ.Text,
                    txtB_ObjPJ.Text,
                    txtB_EpifPJ.Text,
                    txtB_ConfPJ.Text
                    );

                libro.AnadirPersonaje(pj);
                lsB_ListaPJs.Items.Insert(lsB_ListaPJs.Items.Count - 1, pj.Nombre);
            }
            else
            {
                ActualizarPersonaje(lsB_ListaPJs.SelectedIndex);
            }

        }

        /// <summary>
        /// Actualizando personaje con los nuevos parámetros añadidos, modificando los
        /// textboxes que completan la Clase Personaje
        /// </summary>
        /// <param name="indice">Indice de personaje seleccionada en lista</param>
        private void ActualizarPersonaje(int indice)
        {
            libro.listaPersonajes[indice].Nombre = txtB_NombrePJ.Text;
            libro.listaPersonajes[indice].Historia = txtB_HistoriaPJ.Text;
            libro.listaPersonajes[indice].Motivaciones = txtB_MotivPJ.Text;
            libro.listaPersonajes[indice].Objetivo = txtB_ObjPJ.Text;
            libro.listaPersonajes[indice].Epifania = txtB_EpifPJ.Text;
            libro.listaPersonajes[indice].Conflicto = txtB_ConfPJ.Text;
        }

        private void lsB_ListaPJs_SelectedIndexChanged(object sender, EventArgs e)
        {
            CambiarIndex(lsB_ListaPJs.SelectedIndex);
        }

        /// <summary>
        /// Cambiando los campos de cada personaje a medida que son seleccionadas en la lista
        /// </summary>
        /// <param name="indice">Indice de personaje seleccionada en lista</param>
        private void CambiarIndex(int indice)
        {
            if (indice != lsB_ListaPJs.Items.Count - 1)
            {
                txtB_NombrePJ.Text = libro.listaPersonajes[indice].Nombre;
                txtB_HistoriaPJ.Text = libro.listaPersonajes[indice].Historia;
                txtB_MotivPJ.Text = libro.listaPersonajes[indice].Motivaciones;
                txtB_ObjPJ.Text = libro.listaPersonajes[indice].Objetivo;
                txtB_EpifPJ.Text = libro.listaPersonajes[indice].Epifania;
                txtB_ConfPJ.Text = libro.listaPersonajes[indice].Conflicto;
            }
        }
        #endregion
    }
}