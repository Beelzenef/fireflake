namespace LecturaXML
{
    partial class Form1
    {
        /// <summary>
        /// Variable del diseñador requerida.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén utilizando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben eliminar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido del método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.menu_Inicio = new System.Windows.Forms.MenuStrip();
            this.archivoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.nuevoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.abrirToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.guardarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.guardarComoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.edicionToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ayudaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.desarrolloToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.documentacionToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.tbC_Pasos = new System.Windows.Forms.TabControl();
            this.tbP_Inicio = new System.Windows.Forms.TabPage();
            this.tbP_Autor = new System.Windows.Forms.TabPage();
            this.tbP_Paso1 = new System.Windows.Forms.TabPage();
            this.grB_Generos = new System.Windows.Forms.GroupBox();
            this.txtB_Genero = new System.Windows.Forms.TextBox();
            this.grB_Autor = new System.Windows.Forms.GroupBox();
            this.txtB_Autor = new System.Windows.Forms.TextBox();
            this.grB_Subtitulo = new System.Windows.Forms.GroupBox();
            this.txtB_Subtitulo = new System.Windows.Forms.TextBox();
            this.grb_Titulo = new System.Windows.Forms.GroupBox();
            this.txtB_Titulo = new System.Windows.Forms.TextBox();
            this.tbP_Paso2 = new System.Windows.Forms.TabPage();
            this.tbP_Paso3 = new System.Windows.Forms.TabPage();
            this.tbP_Paso4 = new System.Windows.Forms.TabPage();
            this.tbP_Paso5 = new System.Windows.Forms.TabPage();
            this.tbP_Paso6 = new System.Windows.Forms.TabPage();
            this.tbP_Paso7 = new System.Windows.Forms.TabPage();
            this.tbP_Paso8 = new System.Windows.Forms.TabPage();
            this.tbP_Paso9 = new System.Windows.Forms.TabPage();
            this.tbP_Generar = new System.Windows.Forms.TabPage();
            this.sFD_GuardarXML = new System.Windows.Forms.SaveFileDialog();
            this.oFD_AbrirXML = new System.Windows.Forms.OpenFileDialog();
            this.menu_Inicio.SuspendLayout();
            this.tbC_Pasos.SuspendLayout();
            this.tbP_Paso1.SuspendLayout();
            this.grB_Generos.SuspendLayout();
            this.grB_Autor.SuspendLayout();
            this.grB_Subtitulo.SuspendLayout();
            this.grb_Titulo.SuspendLayout();
            this.SuspendLayout();
            // 
            // menu_Inicio
            // 
            this.menu_Inicio.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.archivoToolStripMenuItem,
            this.edicionToolStripMenuItem,
            this.ayudaToolStripMenuItem});
            this.menu_Inicio.Location = new System.Drawing.Point(0, 0);
            this.menu_Inicio.Name = "menu_Inicio";
            this.menu_Inicio.Size = new System.Drawing.Size(589, 24);
            this.menu_Inicio.TabIndex = 3;
            this.menu_Inicio.Text = "menuStrip1";
            // 
            // archivoToolStripMenuItem
            // 
            this.archivoToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.nuevoToolStripMenuItem,
            this.abrirToolStripMenuItem,
            this.guardarToolStripMenuItem,
            this.guardarComoToolStripMenuItem});
            this.archivoToolStripMenuItem.Name = "archivoToolStripMenuItem";
            this.archivoToolStripMenuItem.Size = new System.Drawing.Size(60, 20);
            this.archivoToolStripMenuItem.Text = "Archivo";
            // 
            // nuevoToolStripMenuItem
            // 
            this.nuevoToolStripMenuItem.Name = "nuevoToolStripMenuItem";
            this.nuevoToolStripMenuItem.Size = new System.Drawing.Size(159, 22);
            this.nuevoToolStripMenuItem.Text = "Nuevo";
            // 
            // abrirToolStripMenuItem
            // 
            this.abrirToolStripMenuItem.Name = "abrirToolStripMenuItem";
            this.abrirToolStripMenuItem.Size = new System.Drawing.Size(159, 22);
            this.abrirToolStripMenuItem.Text = "Abrir";
            this.abrirToolStripMenuItem.Click += new System.EventHandler(this.abrirToolStripMenuItem_Click);
            // 
            // guardarToolStripMenuItem
            // 
            this.guardarToolStripMenuItem.Name = "guardarToolStripMenuItem";
            this.guardarToolStripMenuItem.Size = new System.Drawing.Size(159, 22);
            this.guardarToolStripMenuItem.Text = "Guardar";
            this.guardarToolStripMenuItem.Click += new System.EventHandler(this.guardarToolStripMenuItem_Click);
            // 
            // guardarComoToolStripMenuItem
            // 
            this.guardarComoToolStripMenuItem.Name = "guardarComoToolStripMenuItem";
            this.guardarComoToolStripMenuItem.Size = new System.Drawing.Size(159, 22);
            this.guardarComoToolStripMenuItem.Text = "Guardar como...";
            // 
            // edicionToolStripMenuItem
            // 
            this.edicionToolStripMenuItem.Name = "edicionToolStripMenuItem";
            this.edicionToolStripMenuItem.Size = new System.Drawing.Size(58, 20);
            this.edicionToolStripMenuItem.Text = "Edicion";
            // 
            // ayudaToolStripMenuItem
            // 
            this.ayudaToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.desarrolloToolStripMenuItem,
            this.documentacionToolStripMenuItem});
            this.ayudaToolStripMenuItem.Name = "ayudaToolStripMenuItem";
            this.ayudaToolStripMenuItem.Size = new System.Drawing.Size(53, 20);
            this.ayudaToolStripMenuItem.Text = "Ayuda";
            // 
            // desarrolloToolStripMenuItem
            // 
            this.desarrolloToolStripMenuItem.Name = "desarrolloToolStripMenuItem";
            this.desarrolloToolStripMenuItem.Size = new System.Drawing.Size(159, 22);
            this.desarrolloToolStripMenuItem.Text = "Desarrollo";
            // 
            // documentacionToolStripMenuItem
            // 
            this.documentacionToolStripMenuItem.Name = "documentacionToolStripMenuItem";
            this.documentacionToolStripMenuItem.Size = new System.Drawing.Size(159, 22);
            this.documentacionToolStripMenuItem.Text = "Documentacion";
            // 
            // tbC_Pasos
            // 
            this.tbC_Pasos.Controls.Add(this.tbP_Inicio);
            this.tbC_Pasos.Controls.Add(this.tbP_Autor);
            this.tbC_Pasos.Controls.Add(this.tbP_Paso1);
            this.tbC_Pasos.Controls.Add(this.tbP_Paso2);
            this.tbC_Pasos.Controls.Add(this.tbP_Paso3);
            this.tbC_Pasos.Controls.Add(this.tbP_Paso4);
            this.tbC_Pasos.Controls.Add(this.tbP_Paso5);
            this.tbC_Pasos.Controls.Add(this.tbP_Paso6);
            this.tbC_Pasos.Controls.Add(this.tbP_Paso7);
            this.tbC_Pasos.Controls.Add(this.tbP_Paso8);
            this.tbC_Pasos.Controls.Add(this.tbP_Paso9);
            this.tbC_Pasos.Controls.Add(this.tbP_Generar);
            this.tbC_Pasos.Location = new System.Drawing.Point(12, 27);
            this.tbC_Pasos.Name = "tbC_Pasos";
            this.tbC_Pasos.SelectedIndex = 0;
            this.tbC_Pasos.Size = new System.Drawing.Size(565, 303);
            this.tbC_Pasos.TabIndex = 4;
            // 
            // tbP_Inicio
            // 
            this.tbP_Inicio.Location = new System.Drawing.Point(4, 22);
            this.tbP_Inicio.Name = "tbP_Inicio";
            this.tbP_Inicio.Padding = new System.Windows.Forms.Padding(3);
            this.tbP_Inicio.Size = new System.Drawing.Size(557, 277);
            this.tbP_Inicio.TabIndex = 0;
            this.tbP_Inicio.Text = "Inicio";
            this.tbP_Inicio.UseVisualStyleBackColor = true;
            // 
            // tbP_Autor
            // 
            this.tbP_Autor.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.tbP_Autor.Location = new System.Drawing.Point(4, 22);
            this.tbP_Autor.Name = "tbP_Autor";
            this.tbP_Autor.Padding = new System.Windows.Forms.Padding(3);
            this.tbP_Autor.Size = new System.Drawing.Size(557, 277);
            this.tbP_Autor.TabIndex = 1;
            this.tbP_Autor.Text = "Autor";
            this.tbP_Autor.UseVisualStyleBackColor = true;
            // 
            // tbP_Paso1
            // 
            this.tbP_Paso1.Controls.Add(this.grB_Generos);
            this.tbP_Paso1.Controls.Add(this.grB_Autor);
            this.tbP_Paso1.Controls.Add(this.grB_Subtitulo);
            this.tbP_Paso1.Controls.Add(this.grb_Titulo);
            this.tbP_Paso1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbP_Paso1.Location = new System.Drawing.Point(4, 22);
            this.tbP_Paso1.Name = "tbP_Paso1";
            this.tbP_Paso1.Padding = new System.Windows.Forms.Padding(3);
            this.tbP_Paso1.Size = new System.Drawing.Size(557, 277);
            this.tbP_Paso1.TabIndex = 2;
            this.tbP_Paso1.Text = "Paso 1";
            this.tbP_Paso1.UseVisualStyleBackColor = true;
            // 
            // grB_Generos
            // 
            this.grB_Generos.Controls.Add(this.txtB_Genero);
            this.grB_Generos.Location = new System.Drawing.Point(155, 193);
            this.grB_Generos.Name = "grB_Generos";
            this.grB_Generos.Size = new System.Drawing.Size(379, 54);
            this.grB_Generos.TabIndex = 5;
            this.grB_Generos.TabStop = false;
            this.grB_Generos.Text = "Genero(s)";
            // 
            // txtB_Genero
            // 
            this.txtB_Genero.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtB_Genero.Location = new System.Drawing.Point(61, 16);
            this.txtB_Genero.Name = "txtB_Genero";
            this.txtB_Genero.Size = new System.Drawing.Size(266, 24);
            this.txtB_Genero.TabIndex = 0;
            // 
            // grB_Autor
            // 
            this.grB_Autor.Controls.Add(this.txtB_Autor);
            this.grB_Autor.Location = new System.Drawing.Point(155, 141);
            this.grB_Autor.Name = "grB_Autor";
            this.grB_Autor.Size = new System.Drawing.Size(379, 54);
            this.grB_Autor.TabIndex = 5;
            this.grB_Autor.TabStop = false;
            this.grB_Autor.Text = "Autor";
            // 
            // txtB_Autor
            // 
            this.txtB_Autor.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtB_Autor.Location = new System.Drawing.Point(61, 16);
            this.txtB_Autor.Name = "txtB_Autor";
            this.txtB_Autor.Size = new System.Drawing.Size(266, 24);
            this.txtB_Autor.TabIndex = 0;
            // 
            // grB_Subtitulo
            // 
            this.grB_Subtitulo.Controls.Add(this.txtB_Subtitulo);
            this.grB_Subtitulo.Location = new System.Drawing.Point(155, 89);
            this.grB_Subtitulo.Name = "grB_Subtitulo";
            this.grB_Subtitulo.Size = new System.Drawing.Size(379, 54);
            this.grB_Subtitulo.TabIndex = 5;
            this.grB_Subtitulo.TabStop = false;
            this.grB_Subtitulo.Text = "Subtitulo";
            // 
            // txtB_Subtitulo
            // 
            this.txtB_Subtitulo.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtB_Subtitulo.Location = new System.Drawing.Point(61, 16);
            this.txtB_Subtitulo.Name = "txtB_Subtitulo";
            this.txtB_Subtitulo.Size = new System.Drawing.Size(266, 24);
            this.txtB_Subtitulo.TabIndex = 0;
            // 
            // grb_Titulo
            // 
            this.grb_Titulo.Controls.Add(this.txtB_Titulo);
            this.grb_Titulo.Location = new System.Drawing.Point(155, 37);
            this.grb_Titulo.Name = "grb_Titulo";
            this.grb_Titulo.Size = new System.Drawing.Size(379, 54);
            this.grb_Titulo.TabIndex = 4;
            this.grb_Titulo.TabStop = false;
            this.grb_Titulo.Text = "Titulo";
            // 
            // txtB_Titulo
            // 
            this.txtB_Titulo.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtB_Titulo.Location = new System.Drawing.Point(61, 16);
            this.txtB_Titulo.Name = "txtB_Titulo";
            this.txtB_Titulo.Size = new System.Drawing.Size(266, 24);
            this.txtB_Titulo.TabIndex = 0;
            // 
            // tbP_Paso2
            // 
            this.tbP_Paso2.Location = new System.Drawing.Point(4, 22);
            this.tbP_Paso2.Name = "tbP_Paso2";
            this.tbP_Paso2.Padding = new System.Windows.Forms.Padding(3);
            this.tbP_Paso2.Size = new System.Drawing.Size(557, 277);
            this.tbP_Paso2.TabIndex = 3;
            this.tbP_Paso2.Text = "Paso 2";
            this.tbP_Paso2.UseVisualStyleBackColor = true;
            // 
            // tbP_Paso3
            // 
            this.tbP_Paso3.Location = new System.Drawing.Point(4, 22);
            this.tbP_Paso3.Name = "tbP_Paso3";
            this.tbP_Paso3.Padding = new System.Windows.Forms.Padding(3);
            this.tbP_Paso3.Size = new System.Drawing.Size(557, 277);
            this.tbP_Paso3.TabIndex = 4;
            this.tbP_Paso3.Text = "Paso 3";
            this.tbP_Paso3.UseVisualStyleBackColor = true;
            // 
            // tbP_Paso4
            // 
            this.tbP_Paso4.Location = new System.Drawing.Point(4, 22);
            this.tbP_Paso4.Name = "tbP_Paso4";
            this.tbP_Paso4.Padding = new System.Windows.Forms.Padding(3);
            this.tbP_Paso4.Size = new System.Drawing.Size(557, 277);
            this.tbP_Paso4.TabIndex = 5;
            this.tbP_Paso4.Text = "Paso 4";
            this.tbP_Paso4.UseVisualStyleBackColor = true;
            // 
            // tbP_Paso5
            // 
            this.tbP_Paso5.Location = new System.Drawing.Point(4, 22);
            this.tbP_Paso5.Name = "tbP_Paso5";
            this.tbP_Paso5.Padding = new System.Windows.Forms.Padding(3);
            this.tbP_Paso5.Size = new System.Drawing.Size(557, 277);
            this.tbP_Paso5.TabIndex = 6;
            this.tbP_Paso5.Text = "Paso 5";
            this.tbP_Paso5.UseVisualStyleBackColor = true;
            // 
            // tbP_Paso6
            // 
            this.tbP_Paso6.Location = new System.Drawing.Point(4, 22);
            this.tbP_Paso6.Name = "tbP_Paso6";
            this.tbP_Paso6.Padding = new System.Windows.Forms.Padding(3);
            this.tbP_Paso6.Size = new System.Drawing.Size(557, 277);
            this.tbP_Paso6.TabIndex = 7;
            this.tbP_Paso6.Text = "Paso 6";
            this.tbP_Paso6.UseVisualStyleBackColor = true;
            // 
            // tbP_Paso7
            // 
            this.tbP_Paso7.Location = new System.Drawing.Point(4, 22);
            this.tbP_Paso7.Name = "tbP_Paso7";
            this.tbP_Paso7.Padding = new System.Windows.Forms.Padding(3);
            this.tbP_Paso7.Size = new System.Drawing.Size(557, 277);
            this.tbP_Paso7.TabIndex = 8;
            this.tbP_Paso7.Text = "Paso 7";
            this.tbP_Paso7.UseVisualStyleBackColor = true;
            // 
            // tbP_Paso8
            // 
            this.tbP_Paso8.Location = new System.Drawing.Point(4, 22);
            this.tbP_Paso8.Name = "tbP_Paso8";
            this.tbP_Paso8.Size = new System.Drawing.Size(557, 277);
            this.tbP_Paso8.TabIndex = 9;
            this.tbP_Paso8.Text = "Paso 8";
            this.tbP_Paso8.UseVisualStyleBackColor = true;
            // 
            // tbP_Paso9
            // 
            this.tbP_Paso9.Location = new System.Drawing.Point(4, 22);
            this.tbP_Paso9.Name = "tbP_Paso9";
            this.tbP_Paso9.Size = new System.Drawing.Size(557, 277);
            this.tbP_Paso9.TabIndex = 10;
            this.tbP_Paso9.Text = "Paso 9";
            this.tbP_Paso9.UseVisualStyleBackColor = true;
            // 
            // tbP_Generar
            // 
            this.tbP_Generar.Location = new System.Drawing.Point(4, 22);
            this.tbP_Generar.Name = "tbP_Generar";
            this.tbP_Generar.Padding = new System.Windows.Forms.Padding(3);
            this.tbP_Generar.Size = new System.Drawing.Size(557, 277);
            this.tbP_Generar.TabIndex = 11;
            this.tbP_Generar.Text = "Generar";
            this.tbP_Generar.UseVisualStyleBackColor = true;
            // 
            // oFD_AbrirXML
            // 
            this.oFD_AbrirXML.FileName = "openFileDialog1";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.ClientSize = new System.Drawing.Size(589, 342);
            this.Controls.Add(this.tbC_Pasos);
            this.Controls.Add(this.menu_Inicio);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MainMenuStrip = this.menu_Inicio;
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.Text = "Snowflake pocoPro";
            this.menu_Inicio.ResumeLayout(false);
            this.menu_Inicio.PerformLayout();
            this.tbC_Pasos.ResumeLayout(false);
            this.tbP_Paso1.ResumeLayout(false);
            this.grB_Generos.ResumeLayout(false);
            this.grB_Generos.PerformLayout();
            this.grB_Autor.ResumeLayout(false);
            this.grB_Autor.PerformLayout();
            this.grB_Subtitulo.ResumeLayout(false);
            this.grB_Subtitulo.PerformLayout();
            this.grb_Titulo.ResumeLayout(false);
            this.grb_Titulo.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menu_Inicio;
        private System.Windows.Forms.ToolStripMenuItem archivoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem nuevoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem guardarToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem abrirToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem edicionToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem ayudaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem desarrolloToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem documentacionToolStripMenuItem;
        private System.Windows.Forms.TabControl tbC_Pasos;
        private System.Windows.Forms.TabPage tbP_Inicio;
        private System.Windows.Forms.TabPage tbP_Autor;
        private System.Windows.Forms.ToolStripMenuItem guardarComoToolStripMenuItem;
        private System.Windows.Forms.TabPage tbP_Paso1;
        private System.Windows.Forms.TabPage tbP_Paso2;
        private System.Windows.Forms.TabPage tbP_Paso3;
        private System.Windows.Forms.TabPage tbP_Paso4;
        private System.Windows.Forms.TabPage tbP_Paso5;
        private System.Windows.Forms.TabPage tbP_Paso6;
        private System.Windows.Forms.TabPage tbP_Paso7;
        private System.Windows.Forms.TextBox txtB_Titulo;
        private System.Windows.Forms.TabPage tbP_Paso8;
        private System.Windows.Forms.TabPage tbP_Paso9;
        private System.Windows.Forms.TabPage tbP_Generar;
        private System.Windows.Forms.GroupBox grB_Generos;
        private System.Windows.Forms.TextBox txtB_Genero;
        private System.Windows.Forms.GroupBox grB_Autor;
        private System.Windows.Forms.TextBox txtB_Autor;
        private System.Windows.Forms.GroupBox grB_Subtitulo;
        private System.Windows.Forms.TextBox txtB_Subtitulo;
        private System.Windows.Forms.GroupBox grb_Titulo;
        private System.Windows.Forms.SaveFileDialog sFD_GuardarXML;
        private System.Windows.Forms.OpenFileDialog oFD_AbrirXML;
    }
}

