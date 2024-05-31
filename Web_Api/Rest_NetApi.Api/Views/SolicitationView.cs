using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Interface.IEntity;

namespace Rest_NetApi.Api.Views
{
    public class SolicitationView
    {
        public Guid Id { get; set; }
        public string station { get; set; }
        public string address { get; set; }
        public double latitutde { get; set; }
        public double longitude { get; set; }
        public bool hasBikeShared { get; set; }
        public string stationReturn { get; set; }


        public SolicitationView() { }
        public SolicitationView(Guid id, string station, string address, double latitutde, double longitude, bool hasBikeShared, string stationReturn)
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
