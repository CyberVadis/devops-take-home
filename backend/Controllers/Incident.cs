using System;
using Newtonsoft.Json;

namespace devops_app_api.Controllers
{
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