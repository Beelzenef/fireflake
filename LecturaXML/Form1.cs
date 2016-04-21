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
        bool guardado = false;
        string ruta = string.Empty;

        private void guardarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            lib1 = new Libro(txtB_Titulo.Text, txtB_Subtitulo.Text, txtB_Genero.Text, txtB_Autor.Text);
            GestionXML.GuardarXML(ruta, lib1);
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
            GestionXML.AbrirXML(oFD_AbrirXML.FileName);
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

    }
}
