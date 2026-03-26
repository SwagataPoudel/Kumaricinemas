using System;
using System.Data;
using System.Configuration;
using Oracle.ManagedDataAccess.Client;

public class DBHelper
{
    static string connStr = ConfigurationManager
        .ConnectionStrings["OracleConn"].ConnectionString;

    public static DataTable GetData(string query)
    {
        DataTable dt = new DataTable();
        using (OracleConnection conn = new OracleConnection(connStr))
        {
            conn.Open();
            OracleDataAdapter da = new OracleDataAdapter(query, conn);
            da.Fill(dt);
        }
        return dt;
    }

    public static void ExecuteQuery(string query)
    {
        using (OracleConnection conn = new OracleConnection(connStr))
        {
            conn.Open();
            OracleCommand cmd = new OracleCommand(query, conn);
            cmd.ExecuteNonQuery();
        }
    }
}