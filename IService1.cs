using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WCFServicioLibreria
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "IService1" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface IService1
    {

        [OperationContract]
        string GetData(int value);

        [OperationContract]
        CompositeType GetDataUsingDataContract(CompositeType composite);

        // TODO: agregue aquí sus operaciones de servicio
        [OperationContract]
        List<DtoLibro> SP_LISTARVISTALIBROS(string code);

        [OperationContract]
        void SP_RESERVARLIBRO(Reservation reservation);

        [OperationContract]
        User SP_OBTENERUSUARIOXEMAIL(string email);

        [OperationContract]
        int SP_VALIDARRESERVAXLIBRO(string code);

        [OperationContract]
        int SP_VALIDARRESERVAXUSUARIOXLIBRO(int idUser, string varCode);

        [OperationContract]
        Book SP_BUSCARLIBROXCODE(string code);

        [OperationContract]
        void SP_RESERVARCOLA(int idUser, int idBook);
        [OperationContract]
        int SP_VALIDARCOLA(int idUser, int idBook);
        [OperationContract]
        List<MensajeNotificacion> SP_LISTARNOTIFICACIONESXUSUARIO(int idUser);
    }


    // Utilice un contrato de datos, como se ilustra en el ejemplo siguiente, para agregar tipos compuestos a las operaciones de servicio.
    [DataContract]
    public class CompositeType
    {
        bool boolValue = true;
        string stringValue = "Hello ";

        [DataMember]
        public bool BoolValue
        {
            get { return boolValue; }
            set { boolValue = value; }
        }

        [DataMember]
        public string StringValue
        {
            get { return stringValue; }
            set { stringValue = value; }
        }
    }

    public class User
    {

        private int _idUser;
        [DataMember]
        public int idUser
        {
            get { return _idUser; }
            set { _idUser = value; }
        }

        private string _varFirstName;
        [DataMember]
        public string varFirstName
        {
            get { return _varFirstName; }
            set { _varFirstName = value; }
        }

        private string _varLastName;
        [DataMember]
        public string varLastName
        {
            get { return _varLastName; }
            set { _varLastName = value; }
        }

        private string _varEmail;
        [DataMember]
        public string varEmail
        {
            get { return _varEmail; }
            set { _varEmail = value; }
        }

        private string _varPassword;
        [DataMember]
        public string varPassword
        {
            get { return _varPassword; }
            set { _varPassword = value; }
        }

        private int _intStatus;
        [DataMember]
        public int intStatus
        {
            get { return _intStatus; }
            set { _intStatus = value; }
        }

        private DateTime _dmeDateCreate;
        [DataMember]
        public DateTime dmeDateCreate
        {
            get { return _dmeDateCreate;}
            set { _dmeDateCreate = value;}
        }

        private DateTime? _dmeDateUpdate;
        [DataMember]
        public DateTime? dmeDateUpdate
        {
            get { return _dmeDateUpdate;}
            set { _dmeDateUpdate = value;}
        }

        private Boolean _bolIsActive;
        [DataMember]
        public Boolean bolIsActive
        {
            get { return _bolIsActive; }
            set { _bolIsActive = value; }
        }
    }

    public class Book
    {
        private int _idBook;
        [DataMember]
        public int idBook
        {
            get { return _idBook; }
            set { _idBook = value; }
        }

        private string _varTitle;
        [DataMember]
        public string varTitle
        {
            get { return _varTitle; }
            set { _varTitle = value; }
        }

        private string _varCode;
        [DataMember]
        public string varCode
        {
            get { return _varCode; }
            set { _varCode = value; }
        }

        private int _intStatus;
        [DataMember]
        public int intStatus
        {
            get { return _intStatus; }
            set { _intStatus = value; }
        }

        private DateTime _dmeDateCreate;
        [DataMember]
        public DateTime dmeDateCreate
        {
            get { return _dmeDateCreate; }
            set { _dmeDateCreate = value; }
        }

        private DateTime? _dmeDateUpdate;
        [DataMember]
        public DateTime? dmeDateUpdate
        {
            get { return _dmeDateUpdate; }
            set { _dmeDateUpdate = value; }
        }

        private Boolean _bolIsReservated;
        [DataMember]
        public Boolean bolIsReservated
        {
            get { return _bolIsReservated; }
            set { _bolIsReservated = value; }
        }

        private Boolean _bolIsActive;
        [DataMember]
        public Boolean bolIsActive
        {
            get { return _bolIsActive; }
            set { _bolIsActive = value; }
        }
    }

    public class Reservation
    {
        private int _idReservation;
        [DataMember]
        public int idReservation
        {
            get { return _idReservation; }
            set { _idReservation = value; }
        }
        private int _idUser;
        [DataMember]
        public int idUser
        {
            get { return _idUser; }
            set { _idUser = value; }
        }

        private int _idBook;
        [DataMember]
        public int idBook
        {
            get { return _idBook; }
            set { _idBook = value; }
        }

        private DateTime _dmeDateReservation;
        [DataMember]
        public DateTime dmeDateReservation
        {
            get { return _dmeDateReservation; }
            set { _dmeDateReservation = value; }
        }

        private int _intStatus;
        [DataMember]
        public int intStatus
        {
            get { return _intStatus; }
            set { _intStatus = value; }
        }

        private DateTime _dmeDateCreate;
        [DataMember]
        public DateTime dmeDateCreate
        {
            get { return _dmeDateCreate; }
            set { _dmeDateCreate = value; }
        }

        private DateTime _dmeDateUpdate;
        [DataMember]
        public DateTime dmeDateUpdate
        {
            get { return _dmeDateUpdate; }
            set { _dmeDateUpdate = value; }
        }

        private Boolean _bolIsActive;
        [DataMember]
        public Boolean bolIsActive
        {
            get { return _bolIsActive; }
            set { _bolIsActive = value; }
        }


    }

    public class DtoLibro
    {
        private int _idItem;
        public int idItem
        {
            get { return _idItem; }
            set { _idItem = value; }
        }

        private string _varCode;
        [DataMember]
        public string varCode
        {
            get { return _varCode; }
            set { _varCode = value; }
        }

        private string _varTitle;
        [DataMember]
        public string varTitle
        {
            get { return _varTitle; }
            set { _varTitle = value; }
        }
        private DateTime? _dmeDateReservation;
        [DataMember]
        public DateTime? dmeDateReservation
        {
            get { return _dmeDateReservation; }
            set { _dmeDateReservation = value; }
        }

        private string _varStatus;
        [DataMember]
        public string varStatus
        {
            get { return _varStatus; }
            set { _varStatus = value; }
        }
    }

    public class UserNotification
    {
        private int _idNotificacion;
        [DataMember]
        public int idNotificacion
        {
            get { return _idNotificacion;}
            set { _idNotificacion = value;}
        }

        private int _idUser;
        [DataMember]
        public int idUser
        {
            get { return _idUser; }
            set { _idUser = value; }
        }

        private string _varDescription;
        [DataMember]
        public string varDescription
        {
            get { return _varDescription; }
            set { _varDescription = value; }
        }

        private int _intStatus;
        [DataMember]
        public int intStatus
        {
            get { return _intStatus; }
            set { _intStatus = value; }
        }

        private DateTime _dmeDateCreate;
        [DataMember]
        public DateTime dmeDateCreate
        {
            get { return _dmeDateCreate; }
            set { _dmeDateCreate = value; }
        }

        private DateTime? _dmeDateUpdate;
        [DataMember]
        public DateTime? dmeDateUpdate
        {
            get { return _dmeDateUpdate; }
            set { _dmeDateUpdate = value; }
        }

        private Boolean _bolIsActive;
        [DataMember]
        public Boolean bolIsActive
        {
            get { return _bolIsActive; }
            set { _bolIsActive = value; }
        }
    }

    public class MensajeNotificacion
    {
        private string _varDescription;
        [DataMember]
        public string varDescription
        {
            get { return _varDescription; }
            set { _varDescription = value; }
        }
    }
}
