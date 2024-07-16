using System;
using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Interface.IEntity;

namespace Rest_NetApi.Api.Views
{
	public class ViewParser
	{
		public ViewParser()
		{
		}
        public static UserView Parse(UserDto user)
        {
			return new UserView(user.Id, user.Name, user.Email, user.Password, user.Profile, user.credit);
        }

		public static SolicitationView Parse(SolicitationDto solicitaction)
		{
			return new SolicitationView(solicitaction.Id, solicitaction.station.ToString(), solicitaction.address, solicitaction.latitutde, solicitaction.longitude, solicitaction.hasBikeShared, solicitaction.stationReturn.ToString(), solicitaction.UserId.ToString());
        }

		public static StationView Parse(StationDto station)
		{
            return new StationView(station.Id, station.name, station.address, station.latitutde, station.longitude, station.capacity, station.freeDocks, station.totalGets, station.totalReturns, station.availableBikeShared);
        }
    }
}

