using CrystalReport;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Viewfrm vf = new Viewfrm();
            test rpt = new test();
            vf.crystalReportViewer1.ReportSource = rpt;
            vf.Show();

        }

        private void button2_Click(object sender, EventArgs e)
        {

            Viewfrm vf = new Viewfrm();
            CrystalReport2 rpt = new CrystalReport2();
            vf.crystalReportViewer1.ReportSource = rpt;
            vf.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Viewfrm vf = new Viewfrm();
            CrystalReport3 rpt = new CrystalReport3();
            vf.crystalReportViewer1.ReportSource = rpt;
            vf.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Viewfrm vf = new Viewfrm();
            CrystalReport5 rpt = new CrystalReport5();
            vf.crystalReportViewer1.ReportSource = rpt;
            vf.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            Viewfrm vf = new Viewfrm();
            ExamReport rpt = new ExamReport();
            vf.crystalReportViewer1.ReportSource = rpt;
            vf.Show();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            Viewfrm vf = new Viewfrm();
            StudentAnswers rpt = new StudentAnswers();
            vf.crystalReportViewer1.ReportSource = rpt;
            vf.Show();
        }
    }
}
