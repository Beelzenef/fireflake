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
            this.grB_HistoriaProta = new System.Windows.Forms.GroupBox();
            this.txtB_historiaProta = new System.Windows.Forms.TextBox();
            this.grB_EpifProta = new System.Windows.Forms.GroupBox();
            this.txtB_epifProta = new System.Windows.Forms.TextBox();
            this.grB_ConflicProta = new System.Windows.Forms.GroupBox();
            this.txtB_conflicProta = new System.Windows.Forms.TextBox();
            this.grB_MotivProta = new System.Windows.Forms.GroupBox();
            this.txtB_motivProta = new System.Windows.Forms.TextBox();
            this.grB_ObjetivoProta = new System.Windows.Forms.GroupBox();
            this.txtB_objProta = new System.Windows.Forms.TextBox();
            this.grB_nombreProta = new System.Windows.Forms.GroupBox();
            this.txtB_nombreProta = new System.Windows.Forms.TextBox();
            this.tbP_Paso4 = new System.Windows.Forms.TabPage();
            this.tbP_Paso5 = new System.Windows.Forms.TabPage();
            this.tbP_Paso6 = new System.Windows.Forms.TabPage();
            this.tbP_Paso7 = new System.Windows.Forms.TabPage();
            this.tbP_Paso8 = new System.Windows.Forms.TabPage();
            this.btn_BorrarEsc = new System.Windows.Forms.Button();
            this.dataGV_Escenas = new System.Windows.Forms.DataGridView();
            this.tbP_Paso9 = new System.Windows.Forms.TabPage();
            this.tbP_Generar = new System.Windows.Forms.TabPage();
            this.sFD_GuardarXML = new System.Windows.Forms.SaveFileDialog();
            this.oFD_AbrirXML = new System.Windows.Forms.OpenFileDialog();
            this.dataSetXML = new System.Data.DataSet();
            this.menu_Inicio.SuspendLayout();
            this.tbC_Pasos.SuspendLayout();
            this.tbP_Paso1.SuspendLayout();
            this.grB_Generos.SuspendLayout();
            this.grB_Autor.SuspendLayout();
            this.grB_Subtitulo.SuspendLayout();
            this.grb_Titulo.SuspendLayout();
            this.tbP_Paso3.SuspendLayout();
            this.grB_HistoriaProta.SuspendLayout();
            this.grB_EpifProta.SuspendLayout();
            this.grB_ConflicProta.SuspendLayout();
            this.grB_MotivProta.SuspendLayout();
            this.grB_ObjetivoProta.SuspendLayout();
            this.grB_nombreProta.SuspendLayout();
            this.tbP_Paso8.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGV_Escenas)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataSetXML)).BeginInit();
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
            this.guardarComoToolStripMenuItem.Click += new System.EventHandler(this.guardarComoToolStripMenuItem_Click);
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
            this.txtB_Genero.TextChanged += new System.EventHandler(this.DatosCambiados);
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
            this.txtB_Autor.TextChanged += new System.EventHandler(this.DatosCambiados);
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
            this.txtB_Subtitulo.TextChanged += new System.EventHandler(this.DatosCambiados);
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
            this.txtB_Titulo.TextChanged += new System.EventHandler(this.DatosCambiados);
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
            this.tbP_Paso3.Controls.Add(this.grB_HistoriaProta);
            this.tbP_Paso3.Controls.Add(this.grB_EpifProta);
            this.tbP_Paso3.Controls.Add(this.grB_ConflicProta);
            this.tbP_Paso3.Controls.Add(this.grB_MotivProta);
            this.tbP_Paso3.Controls.Add(this.grB_ObjetivoProta);
            this.tbP_Paso3.Controls.Add(this.grB_nombreProta);
            this.tbP_Paso3.Location = new System.Drawing.Point(4, 22);
            this.tbP_Paso3.Name = "tbP_Paso3";
            this.tbP_Paso3.Padding = new System.Windows.Forms.Padding(3);
            this.tbP_Paso3.Size = new System.Drawing.Size(557, 277);
            this.tbP_Paso3.TabIndex = 4;
            this.tbP_Paso3.Text = "Paso 3";
            this.tbP_Paso3.UseVisualStyleBackColor = true;
            // 
            // grB_HistoriaProta
            // 
            this.grB_HistoriaProta.Controls.Add(this.txtB_historiaProta);
            this.grB_HistoriaProta.Location = new System.Drawing.Point(302, 25);
            this.grB_HistoriaProta.Name = "grB_HistoriaProta";
            this.grB_HistoriaProta.Size = new System.Drawing.Size(249, 157);
            this.grB_HistoriaProta.TabIndex = 9;
            this.grB_HistoriaProta.TabStop = false;
            this.grB_HistoriaProta.Text = "Breve historia";
            // 
            // txtB_historiaProta
            // 
            this.txtB_historiaProta.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtB_historiaProta.Location = new System.Drawing.Point(6, 19);
            this.txtB_historiaProta.Multiline = true;
            this.txtB_historiaProta.Name = "txtB_historiaProta";
            this.txtB_historiaProta.Size = new System.Drawing.Size(232, 132);
            this.txtB_historiaProta.TabIndex = 0;
            // 
            // grB_EpifProta
            // 
            this.grB_EpifProta.Controls.Add(this.txtB_epifProta);
            this.grB_EpifProta.Location = new System.Drawing.Point(21, 217);
            this.grB_EpifProta.Name = "grB_EpifProta";
            this.grB_EpifProta.Size = new System.Drawing.Size(262, 54);
            this.grB_EpifProta.TabIndex = 8;
            this.grB_EpifProta.TabStop = false;
            this.grB_EpifProta.Text = "Epifania";
            // 
            // txtB_epifProta
            // 
            this.txtB_epifProta.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtB_epifProta.Location = new System.Drawing.Point(34, 19);
            this.txtB_epifProta.Name = "txtB_epifProta";
            this.txtB_epifProta.Size = new System.Drawing.Size(207, 24);
            this.txtB_epifProta.TabIndex = 0;
            // 
            // grB_ConflicProta
            // 
            this.grB_ConflicProta.Controls.Add(this.txtB_conflicProta);
            this.grB_ConflicProta.Location = new System.Drawing.Point(21, 162);
            this.grB_ConflicProta.Name = "grB_ConflicProta";
            this.grB_ConflicProta.Size = new System.Drawing.Size(262, 54);
            this.grB_ConflicProta.TabIndex = 7;
            this.grB_ConflicProta.TabStop = false;
            this.grB_ConflicProta.Text = "Conflicto";
            // 
            // txtB_conflicProta
            // 
            this.txtB_conflicProta.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtB_conflicProta.Location = new System.Drawing.Point(34, 19);
            this.txtB_conflicProta.Name = "txtB_conflicProta";
            this.txtB_conflicProta.Size = new System.Drawing.Size(207, 24);
            this.txtB_conflicProta.TabIndex = 0;
            // 
            // grB_MotivProta
            // 
            this.grB_MotivProta.Controls.Add(this.txtB_motivProta);
            this.grB_MotivProta.Location = new System.Drawing.Point(21, 110);
            this.grB_MotivProta.Name = "grB_MotivProta";
            this.grB_MotivProta.Size = new System.Drawing.Size(262, 54);
            this.grB_MotivProta.TabIndex = 8;
            this.grB_MotivProta.TabStop = false;
            this.grB_MotivProta.Text = "Motivaciones";
            // 
            // txtB_motivProta
            // 
            this.txtB_motivProta.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtB_motivProta.Location = new System.Drawing.Point(34, 19);
            this.txtB_motivProta.Name = "txtB_motivProta";
            this.txtB_motivProta.Size = new System.Drawing.Size(207, 24);
            this.txtB_motivProta.TabIndex = 0;
            // 
            // grB_ObjetivoProta
            // 
            this.grB_ObjetivoProta.Controls.Add(this.txtB_objProta);
            this.grB_ObjetivoProta.Location = new System.Drawing.Point(21, 58);
            this.grB_ObjetivoProta.Name = "grB_ObjetivoProta";
            this.grB_ObjetivoProta.Size = new System.Drawing.Size(262, 54);
            this.grB_ObjetivoProta.TabIndex = 9;
            this.grB_ObjetivoProta.TabStop = false;
            this.grB_ObjetivoProta.Text = "Objetivo(s)";
            // 
            // txtB_objProta
            // 
            this.txtB_objProta.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtB_objProta.Location = new System.Drawing.Point(34, 19);
            this.txtB_objProta.Name = "txtB_objProta";
            this.txtB_objProta.Size = new System.Drawing.Size(207, 24);
            this.txtB_objProta.TabIndex = 0;
            // 
            // grB_nombreProta
            // 
            this.grB_nombreProta.Controls.Add(this.txtB_nombreProta);
            this.grB_nombreProta.Location = new System.Drawing.Point(21, 6);
            this.grB_nombreProta.Name = "grB_nombreProta";
            this.grB_nombreProta.Size = new System.Drawing.Size(262, 54);
            this.grB_nombreProta.TabIndex = 6;
            this.grB_nombreProta.TabStop = false;
            this.grB_nombreProta.Text = "Nombre";
            // 
            // txtB_nombreProta
            // 
            this.txtB_nombreProta.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtB_nombreProta.Location = new System.Drawing.Point(34, 19);
            this.txtB_nombreProta.Name = "txtB_nombreProta";
            this.txtB_nombreProta.Size = new System.Drawing.Size(207, 24);
            this.txtB_nombreProta.TabIndex = 0;
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
            this.tbP_Paso8.Controls.Add(this.btn_BorrarEsc);
            this.tbP_Paso8.Controls.Add(this.dataGV_Escenas);
            this.tbP_Paso8.Location = new System.Drawing.Point(4, 22);
            this.tbP_Paso8.Name = "tbP_Paso8";
            this.tbP_Paso8.Size = new System.Drawing.Size(557, 277);
            this.tbP_Paso8.TabIndex = 9;
            this.tbP_Paso8.Text = "Paso 8";
            this.tbP_Paso8.UseVisualStyleBackColor = true;
            // 
            // btn_BorrarEsc
            // 
            this.btn_BorrarEsc.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_BorrarEsc.Location = new System.Drawing.Point(26, 233);
            this.btn_BorrarEsc.Name = "btn_BorrarEsc";
            this.btn_BorrarEsc.Size = new System.Drawing.Size(78, 33);
            this.btn_BorrarEsc.TabIndex = 2;
            this.btn_BorrarEsc.Text = "Eliminar";
            this.btn_BorrarEsc.UseVisualStyleBackColor = true;
            this.btn_BorrarEsc.Click += new System.EventHandler(this.EliminarFila);
            // 
            // dataGV_Escenas
            // 
            this.dataGV_Escenas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGV_Escenas.Location = new System.Drawing.Point(17, 13);
            this.dataGV_Escenas.Name = "dataGV_Escenas";
            this.dataGV_Escenas.Size = new System.Drawing.Size(524, 214);
            this.dataGV_Escenas.TabIndex = 0;
            this.dataGV_Escenas.CellValueChanged += new System.Windows.Forms.DataGridViewCellEventHandler(this.CambioCelda);
            this.dataGV_Escenas.RowsAdded += new System.Windows.Forms.DataGridViewRowsAddedEventHandler(this.CambioFilas);
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
            // sFD_GuardarXML
            // 
            this.sFD_GuardarXML.FileName = "FicheroXML";
            this.sFD_GuardarXML.Filter = "XML|*.xml";
            // 
            // oFD_AbrirXML
            // 
            this.oFD_AbrirXML.FileName = "FicheroXML";
            this.oFD_AbrirXML.Filter = "XML|*.xml";
            // 
            // dataSetXML
            // 
            this.dataSetXML.DataSetName = "NewDataSet";
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
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.CerrandoApp);
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
            this.tbP_Paso3.ResumeLayout(false);
            this.grB_HistoriaProta.ResumeLayout(false);
            this.grB_HistoriaProta.PerformLayout();
            this.grB_EpifProta.ResumeLayout(false);
            this.grB_EpifProta.PerformLayout();
            this.grB_ConflicProta.ResumeLayout(false);
            this.grB_ConflicProta.PerformLayout();
            this.grB_MotivProta.ResumeLayout(false);
            this.grB_MotivProta.PerformLayout();
            this.grB_ObjetivoProta.ResumeLayout(false);
            this.grB_ObjetivoProta.PerformLayout();
            this.grB_nombreProta.ResumeLayout(false);
            this.grB_nombreProta.PerformLayout();
            this.tbP_Paso8.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGV_Escenas)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataSetXML)).EndInit();
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
        private System.Windows.Forms.DataGridView dataGV_Escenas;
        private System.Windows.Forms.Button btn_BorrarEsc;
        private System.Data.DataSet dataSetXML;
        private System.Windows.Forms.GroupBox grB_EpifProta;
        private System.Windows.Forms.TextBox txtB_epifProta;
        private System.Windows.Forms.GroupBox grB_ConflicProta;
        private System.Windows.Forms.TextBox txtB_conflicProta;
        private System.Windows.Forms.GroupBox grB_MotivProta;
        private System.Windows.Forms.TextBox txtB_motivProta;
        private System.Windows.Forms.GroupBox grB_ObjetivoProta;
        private System.Windows.Forms.TextBox txtB_objProta;
        private System.Windows.Forms.GroupBox grB_nombreProta;
        private System.Windows.Forms.TextBox txtB_nombreProta;
        private System.Windows.Forms.GroupBox grB_HistoriaProta;
        private System.Windows.Forms.TextBox txtB_historiaProta;
    }
}

