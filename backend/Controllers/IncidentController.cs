using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using Bogus;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace devops_app_api.Controllers
{
    [Route("api/incidents")]
    public class IncidentController : Controller
    {
        [HttpGet]
        [EnableCors("AllowAllOrigins")]
        public IEnumerable<Incident> Get()
        {
            var incidentGenerator = new Faker<Incident>()
                .RuleFor(i => i.Id, () => Guid.NewGuid().ToString())
                .RuleFor(i => i.Title, f => f.Lorem.Sentence(5))
                .RuleFor(i => i.Description, f => f.Lorem.Paragraph())
                .RuleFor(i => i.AffectedCompany, f => f.Company.CompanyName())
                .RuleFor(i => i.Registered, f => f.Date.Past());

            var rnd = new Random();
            return incidentGenerator.Generate(rnd.Next(10, 100)).ToImmutableList();
        }
    }

    public class Incident
    {
        [JsonProperty(PropertyName="_id")]
        public string Id { get; set; }

        [JsonProperty(PropertyName="title")]
        public string Title { get; set; }

        [JsonProperty(PropertyName="description")]
        public string Description { get; set; }

        [JsonProperty(PropertyName="affected-company")]
        public string AffectedCompany { get; set; }

        [JsonProperty(PropertyName="registered")]
        public DateTime Registered { get; set; }
    }
}