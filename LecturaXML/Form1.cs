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

        private void guardarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (sFD_GuardarXML.ShowDialog() != DialogResult.OK)
                return;
            Libro lib1 = new Libro(txtB_Titulo.Text, txtB_Subtitulo.Text, txtB_Genero.Text, txtB_Autor.Text);
            GestionXML.GuardarXML(sFD_GuardarXML.FileName, lib1);
        }

        private void abrirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (oFD_AbrirXML.ShowDialog() != DialogResult.OK)
                return;
            GestionXML.AbrirXML(oFD_AbrirXML.FileName);
        }

        #endregion


    }
}
