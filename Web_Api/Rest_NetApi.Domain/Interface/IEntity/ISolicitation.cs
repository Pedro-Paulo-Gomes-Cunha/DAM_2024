using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Domain.Interface.IEntity
{
    public interface ISolicitation
    {
        Guid Id { get; set; }
        String station { get; set; }
        String address { get; set; }
        double latitutde { get; set; }
        double longitude { get; set; }
        bool hasBikeShared { get; set; }
        string stationReturn { get; set; }
    }
}
