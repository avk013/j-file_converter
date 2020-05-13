using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
//using System.Linq;
using System.Text;
//using System.Threading.Tasks;
using System.Windows.Forms;

namespace j_file
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            openFileDialog1.Filter = "j - Files|*.way";
            openFileDialog1.Title = "Select File";
            openFileDialog1.InitialDirectory = AppDomain.CurrentDomain.BaseDirectory;
            if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                //System.IO.StreamReader sr = new
                  // System.IO.StreamReader(openFileDialog1.FileName);
                //MessageBox.Show(sr.ReadToEnd());
                //sr.Close();
            }
            button1.Text = "ждите!!!";
            //MessageBox.Show(openFileDialog1.FileName);
            string f_p = openFileDialog1.FileName;
           // string f_p=@"E:\!jfile\j3271_01.way";
             if (File.Exists(f_p))
            //if (0==1)
            {
                string f_o = f_p + ".csv";
                string[] array0;
                try
                { array0 = File.ReadAllLines(f_p, Encoding.GetEncoding(1251)); }
                catch (Exception Oops)
                {
                    MessageBox.Show(Oops.Message);
                    array0 = new string[] { "default_value" };
                }
                //string[] array1 = File.ReadAllLines(f_p);
               
                string[] arr2 = new string[9];
                for (int i = 0; i < array0.Length; i++)
                {
                    string s1 = array0[i];
                    int j = 0;
                    //arr2[j++] = s1.Substring(0, s1.IndexOf("  "));
                    arr2[j++] = s1.Substring(0, 35).TrimEnd();
                    s1 = s1.Substring(36, s1.Length - 36);
                    //  s1=s1.TrimStart();
                    arr2[j++] = s1.Substring(0, 35).TrimEnd();
                    s1 = s1.Substring(36, s1.Length - 36);
                    //s1 = s1.TrimStart();
                    arr2[j++] = s1.Substring(0, 35).TrimEnd();
                    s1 = s1.Substring(36, s1.Length - 36);
                    //s1 = s1.TrimStart();
                    arr2[j++] = s1.Substring(0, 35).TrimEnd();
                    s1 = s1.Substring(36, s1.Length - 36);
                    //s1 = s1.TrimStart();
                    arr2[j++] = s1.Substring(0, 25).TrimEnd();
                    s1 = s1.Substring(26, s1.Length - 26);
                    // s1 = s1.TrimStart();
                    arr2[j++] = s1.Substring(0, 25).TrimEnd();
                    s1 = s1.Substring(26, s1.Length - 26);
                    // s1 = s1.TrimStart();
                    arr2[j++] = s1;
                    s1 = "";
                    for (int k = 0; k < arr2.Length; k++)
                    {
                        s1 += arr2[k] + ";";

                    }
                    s1 += Environment.NewLine;
                    //MessageBox.Show(s1);
                    File.AppendAllText(f_o, s1, Encoding.GetEncoding(1251));

                }
                button1.Text = "Готово!!!";
            }
            else button1.Text = "Нет доступа к файлу";
            ///writing
            ///

        }
    }
}
