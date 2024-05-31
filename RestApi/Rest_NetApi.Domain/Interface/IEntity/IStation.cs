using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Domain.Interface.IEntity
{
    public interface IStation
    {
        Guid Id { get; set; }
        String name { get; set; }
        String address { get; set; }
        double latitutde { get; set; }
        double longitude { get; set; }
        int capacity { get; set; }
        int freeDocks { get; set; }
        int totalGets { get; set; }
        int totalReturns { get; set; }
        int availableBikeShared { get; set; }
    }
}
