namespace devops_app_api
{
    public interface IDbConector
    {
        string ConnectionString { get; set; }
    }

    public class DbConector : IDbConector
    {
        public string ConnectionString { get; set; }

        public DbConector(string connectionString)
        {
            ConnectionString = connectionString;
        }
    }
}