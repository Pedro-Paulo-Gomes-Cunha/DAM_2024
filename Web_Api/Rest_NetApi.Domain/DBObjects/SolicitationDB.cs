using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Entities;
using Rest_NetApi.Domain.Interface.IEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Domain.DBObjects
{
    public class SolicitationDB
    {
        public Guid Id { get; set; }
        public Guid station { get; set; }
        public string address { get; set; }
        public double latitutde { get; set; }
        public double longitude { get; set; }
        public bool hasBikeShared { get; set; }
        public Guid stationReturn { get; set; }
        public Guid UserId { get; set; }


        public SolicitationDB() { }

        public SolicitationDB(Guid id, Guid station, string address, double latitutde, double longitude, bool hasBikeShared, Guid stationReturn, Guid userId)
        {
            Id = id;
            this.station = station;
            this.address = address;
            this.latitutde = latitutde;
            this.longitude = longitude;
            this.hasBikeShared = hasBikeShared;
            this.stationReturn = stationReturn;
            this.UserId = userId;
        }

        public SolicitationDto ToDto()
        {
            return new SolicitationDto(this.Id, this.station, this.address, this.latitutde, this.longitude, this.hasBikeShared, this.stationReturn, this.UserId);
        }
    }
}
