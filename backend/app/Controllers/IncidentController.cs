using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Data;
using System.Data.SqlClient;
using Bogus;
using Dapper;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace devops_app_api.Controllers
{
    [Route("api/incidents")]
    public class IncidentController : Controller
    {
        private readonly IDbConector _dbConector;
        private IDbConnection Connection => new SqlConnection(_dbConector.ConnectionString);

        public IncidentController(IDbConector dbConector)
        {
            _dbConector = dbConector;
        }

        [HttpGet]
        [EnableCors(Startup.UnrestrictedAccessPolicy)]
        public IEnumerable<Incident> Get()
        {
            var incidents = new List<Incident>();
            incidents.AddRange(DbIncidents());
            incidents.AddRange(RandomIncidents());
            return incidents.ToImmutableList();
        }

        private IEnumerable<Incident> DbIncidents()
        {
            using (var conn = Connection)
            {
                conn.Open();
                return conn.Query<Incident>("SELECT * FROM Incidents");
            }
        }

        private static List<Incident> RandomIncidents()
        {
            var incidentGenerator = new Faker<Incident>()
                .RuleFor(i => i.Id, () => Guid.NewGuid().ToString())
                .RuleFor(i => i.Title, f => f.Lorem.Sentence(5))
                .RuleFor(i => i.Description, f => f.Lorem.Paragraph())
                .RuleFor(i => i.AffectedCompany, f => f.Company.CompanyName())
                .RuleFor(i => i.Registered, f => f.Date.Past());

            var rnd = new Random();
            return incidentGenerator.Generate(rnd.Next(10, 100));
        }
    }
}