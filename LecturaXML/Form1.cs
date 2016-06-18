using System;
using System.Windows.Forms;

namespace LecturaXML
{
    public partial class Form1 : Form
    {
        Libro lib1 = null;
        public Form1()
        {
            InitializeComponent();
            lib1 = new Libro();
        }

        #region Menu principal

        
        bool guardado = true;
        string rutaFicheroOperando = string.Empty;

        private void guardarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (sFD_GuardarProyecto.ShowDialog() != DialogResult.OK)
                return;
            rutaFicheroOperando = sFD_GuardarProyecto.FileName;
            GestionXML.GuardarXML(rutaFicheroOperando, lib1);
            guardado = true;
        }

        private void guardarComoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (sFD_GuardarProyecto.ShowDialog() != DialogResult.OK)
                return;
            rutaFicheroOperando = sFD_GuardarProyecto.FileName;
            GestionXML.GuardarXML(rutaFicheroOperando, lib1);
            guardado = true;
        }

        private void abrirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (oFD_AbrirProyecto.ShowDialog() != DialogResult.OK)
                return;
            rutaFicheroOperando = oFD_AbrirProyecto.FileName;
            this.Text = GestionXML.AbrirXML(rutaFicheroOperando);
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
                    GestionXML.GuardarXML(rutaFicheroOperando, lib1);
                }
            }

        }

        #endregion

        #region Gestionando DGV

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

        private void GuardarEscenas()
        {
            foreach (DataGridViewRow item in dataGV_Escenas.Rows)
            {
                Escena escTMP = new Escena();
                escTMP.Capitulo = Convert.ToInt32(item.Cells["dgC_Capitulo"].Value);
                escTMP.PoV = item.Cells["dgC_POV"].Value.ToString();
                escTMP.NumEscena = Convert.ToInt32(item.Cells["dgC_NEscena"].Value);
                escTMP.ResumenEscena = item.Cells["dgC_Resumen"].Value.ToString();
                lib1.AnadirEscena(escTMP);
            }
        }

        #endregion

        #region Gestion de nuevo libro

        private void btn_NuevoLibro_Click(object sender, EventArgs e)
        {
            GuardarEscenas();
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

                lib1.AnadirPersonaje(pj);
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
            lib1.listaPersonajes[indice].Nombre = txtB_NombrePJ.Text;
            lib1.listaPersonajes[indice].Historia = txtB_HistoriaPJ.Text;
            lib1.listaPersonajes[indice].Motivaciones = txtB_MotivPJ.Text;
            lib1.listaPersonajes[indice].Objetivo = txtB_ObjPJ.Text;
            lib1.listaPersonajes[indice].Epifania = txtB_EpifPJ.Text;
            lib1.listaPersonajes[indice].Conflicto = txtB_ConfPJ.Text;
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
                txtB_NombrePJ.Text = lib1.listaPersonajes[indice].Nombre;
                txtB_HistoriaPJ.Text = lib1.listaPersonajes[indice].Historia;
                txtB_MotivPJ.Text = lib1.listaPersonajes[indice].Motivaciones;
                txtB_ObjPJ.Text = lib1.listaPersonajes[indice].Objetivo;
                txtB_EpifPJ.Text = lib1.listaPersonajes[indice].Epifania;
                txtB_ConfPJ.Text = lib1.listaPersonajes[indice].Conflicto;
            }
        }
        #endregion

        #region Gestion de protagonista

        private void btn_AnadirProta_Click(object sender, EventArgs e)
        {
            Personaje protaTMP = new Personaje(txtB_nombreProta.Text, txtB_historiaProta.Text, txtB_motivProta.Text,
                                                txtB_objProta.Text, txtB_epifProta.Text, txtB_conflicProta.Text);
            lib1.AnadirProtagonista(protaTMP);
            lib1.listaPersonajes.Add(protaTMP);
        }

        #endregion

        #region Elegir genero

        Libro.ListaGeneros generoElegido;

        private void EligiendoGenero_CMB(object sender, EventArgs e)
        {
            if (cmB_ElegirGenero.SelectedIndex == 0)
                generoElegido = Libro.ListaGeneros.Fantasia;
            else if (cmB_ElegirGenero.SelectedIndex == 1)
                generoElegido = Libro.ListaGeneros.CienciaFiccion;
            else if (cmB_ElegirGenero.SelectedIndex == 2)
                generoElegido = Libro.ListaGeneros.Terror;
            else if (cmB_ElegirGenero.SelectedIndex == 3)
                generoElegido = Libro.ListaGeneros.Cyberpunk;
            else if (cmB_ElegirGenero.SelectedIndex == 4)
                generoElegido = Libro.ListaGeneros.Aventura;
            else if (cmB_ElegirGenero.SelectedIndex == 5)
                generoElegido = Libro.ListaGeneros.Misterio;

            lib1.Genero = generoElegido;
        } 

        #endregion
    }
}