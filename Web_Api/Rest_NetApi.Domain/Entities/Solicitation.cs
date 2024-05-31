using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Interface.IEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Domain.Entities
{
    public class Solicitation : ISolicitation
    {
        public Guid Id { get; set; }
        public string station { get; set; }
        public string address { get; set; }
        public double latitutde { get; set; }
        public double longitude { get; set; }
        public bool hasBikeShared { get; set; }
        public string stationReturn { get; set; }


        public Solicitation() { }

        public Solicitation(ISolicitation Solicitation_): this(Solicitation_.Id, Solicitation_.station, Solicitation_.address, Solicitation_.latitutde, Solicitation_.longitude, Solicitation_.hasBikeShared, Solicitation_.stationReturn) { }
        public Solicitation(Guid id, string station, string address, double latitutde, double longitude, bool hasBikeShared, string stationReturn)
        {
            Id = id;
            this.station = station;
            this.address = address;
            this.latitutde = latitutde;
            this.longitude = longitude;
            this.hasBikeShared = hasBikeShared;
            this.stationReturn = stationReturn;
        }

        public SolicitationDto ToDto()
        {
            return new SolicitationDto(this.Id, this.station, this.address, this.latitutde, this.longitude, this.hasBikeShared, this.stationReturn);
        }
    }
}
