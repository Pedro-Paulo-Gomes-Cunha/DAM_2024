using Rest_NetApi.Domain.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Domain.Interface.IRepository
{
    public interface IStationRepository
    {
        IEnumerable<StationDto> FindAll();
        void Save(StationDto obj);
        StationDto FindById(Guid id);
        void UpdateStation(StationDto obj);
        void RemoveStation(Guid id);
        IEnumerable<StationDto> FindByStationName(string name);
    }
}
