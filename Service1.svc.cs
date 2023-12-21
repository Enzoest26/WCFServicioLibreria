using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Data;

namespace WCFServicioLibreria
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "Service1" en el código, en svc y en el archivo de configuración.
    // NOTE: para iniciar el Cliente de prueba WCF para probar este servicio, seleccione Service1.svc o Service1.svc.cs en el Explorador de soluciones e inicie la depuración.
    public class Service1 : IService1
    {

        SqlConnection cn;

        public SqlConnection conectar()
        {
            try
            {
                cn = new SqlConnection("SERVER=.;DATABASE=dbReto1;Integrated Security=SSPI");
                cn.Open();
                return cn;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<DtoLibro> SP_LISTARVISTALIBROS(string code)
        {
            conectar();
            SqlCommand cmd = new SqlCommand("SP_LISTARVISTALIBROS", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CODE", SqlDbType.VarChar).Value = code == null ? "" : code;
            List<DtoLibro> lstDtoLibros = new List<DtoLibro>();
            try
            {
                SqlDataReader reader = cmd.ExecuteReader();
                int item = 1;
                while (reader.Read())
                {
                    DtoLibro dtoLibro = new DtoLibro
                    {
                        idItem = item,
                        varCode = reader.GetString(0),
                        varTitle = reader.GetString(1),
                        varStatus = reader.GetString(2),
                        dmeDateReservation = !reader.IsDBNull(3) ? (DateTime?)reader.GetDateTime(3) : null

                    };
                    item++;
                    lstDtoLibros.Add(dtoLibro);
                }
            }
            catch (Exception)
            {
                throw;
            }
            return lstDtoLibros;
        }

        public void SP_RESERVARLIBRO(Reservation reservation)
        {
            conectar();
            SqlCommand cmd = new SqlCommand("SP_RESERVARLIBRO", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@ID_USER", SqlDbType.Int).Value = reservation.idUser;
            cmd.Parameters.Add("@ID_BOOK", SqlDbType.VarChar).Value = reservation.idBook;
            cmd.Parameters.Add("@DATE_RESERVATION", SqlDbType.DateTime).Value = reservation.dmeDateReservation;
            cmd.Parameters.Add("@DATE_CREATED", SqlDbType.DateTime).Value = reservation.dmeDateCreate;
            cmd.Parameters.Add("@STATUS", SqlDbType.Int).Value = reservation.intStatus;
            cmd.Parameters.Add("@ACTIVE", SqlDbType.Bit).Value = reservation.bolIsActive;
           
            try
            {
               cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public User SP_OBTENERUSUARIOXEMAIL(string email)
        {
            if(email == null)
            {
                return null;
            }
            conectar();
            SqlCommand cmd = new SqlCommand("SP_OBTENERUSUARIOXEMAIL", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@EMAIL", SqlDbType.VarChar).Value = email;
            User user = new User();
            try
            {
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        user.idUser = reader.GetInt32(0);
                        user.varFirstName = reader.GetString(1);
                        user.varLastName = reader.GetString(2);
                        user.varEmail = reader.GetString(3);
                        user.varPassword = reader.GetString(4);
                        user.intStatus = reader.GetInt32(5);
                        user.dmeDateCreate = reader.GetDateTime(6);
                        user.dmeDateUpdate = !reader.IsDBNull(7) ? (DateTime?)reader.GetDateTime(7) : null;
                        user.bolIsActive = reader.GetBoolean(8);
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            return user;
        }

        public int SP_VALIDARRESERVA(string varCode)
        {
            conectar();
            SqlCommand cmd = new SqlCommand("SP_VALIDARRESERVA", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CODE_BOOK", SqlDbType.VarChar).Value = varCode;
            int verdad = 1; //0 - No hay reserva y 1 - Hay Reserva
            try
            {
                SqlDataReader reader = cmd.ExecuteReader();
                while(reader.Read())
                {
                    verdad = reader.GetInt32(0);
                }
            }
            catch (Exception) 
            { 
                throw;
            }
            return verdad;
        }

        public Book SP_BUSCARLIBROXCODE(string code)
        {
            if(code == null)
            {
                return null;
            }
            conectar();
            SqlCommand cmd = new SqlCommand("SP_BUSCARLIBROXCODE", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CODE_BOOK", SqlDbType.VarChar).Value = code;
            Book book = new Book();
            try
            {
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        book.idBook = reader.GetInt32(0);
                        book.varTitle = reader.GetString(1);
                        book.varCode = reader.GetString(2);
                        book.intStatus = reader.GetInt32(3);
                        book.dmeDateCreate = reader.GetDateTime(4);
                        book.dmeDateUpdate = !reader.IsDBNull(5) ? (DateTime?)reader.GetDateTime(5) : null;
                        book.bolIsReservated = reader.GetBoolean(6);
                        book.bolIsActive = reader.GetBoolean(7);
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            return book;
        }


        public string GetData(int value)
        {
            return string.Format("You entered: {0}", value);
        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }
    }
}
