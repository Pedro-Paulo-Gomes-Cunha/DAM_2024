using Rest_NetApi.Domain.DBObjects;
using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Interface.IEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Domain.Entities
{
    public class Station : IStation
    {
        public Guid Id { get ; set ; }
        public string name { get ; set ; }
        public string address { get ; set ; }
        public double latitutde { get ; set ; }
        public double longitude { get ; set ; }
        public int capacity { get ; set ; }
        public int freeDocks { get ; set ; }
        public int totalGets { get ; set ; }
        public int totalReturns { get ; set ; }
        public int availableBikeShared { get ; set ; }

        public Station() { }
        public Station(IStation station_): this(station_.Id, station_.name, station_.address, station_.latitutde, station_.longitude, station_.capacity, station_.freeDocks, station_.totalGets, station_.totalReturns, station_.availableBikeShared) { }
        public Station(Guid id, string name, string address, double latitutde, double longitude, int capacity, int freeDocks, int totalGets, int totalReturns, int availableBikeShared)
        {
            Id = id;
            this.name = name;
            this.address = address;
            this.latitutde = latitutde;
            this.longitude = longitude;
            this.capacity = capacity;
            this.freeDocks = freeDocks;
            this.totalGets = totalGets;
            this.totalReturns = totalReturns;
            this.availableBikeShared = availableBikeShared;
        }
        public StationDto ToDto()
        {
            return new StationDto(this.Id, this.name, this.address, this.latitutde, this.longitude, this.capacity, this.freeDocks, this.totalGets, this.totalReturns, this.availableBikeShared);
        }

    }
}
