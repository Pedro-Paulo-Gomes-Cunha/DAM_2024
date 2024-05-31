using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Interface.IRepository;
using Rest_NetApi.Domain.Interface.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Domain.Service
{
    public class StationService: IStationService
    {
        IRepositoryWrapper _repositoryWrapper;
        public StationService(IRepositoryWrapper repositoryWrapper) {
            this._repositoryWrapper = repositoryWrapper;
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<StationDto> FindAll()
        {
            return this._repositoryWrapper.StationRepositoy.FindAll();
        }

        public StationDto FindById(Guid id)
        {
            return this._repositoryWrapper.StationRepositoy.FindById(id);
        }

        public IEnumerable<StationDto> FindByStationName(string name)
        {
            return this._repositoryWrapper.StationRepositoy.FindByStationName(name);
        }

        public void Remove(Guid id)
        {
            this._repositoryWrapper.StationRepositoy.RemoveStation(id);
        }

        public void Save(StationDto obj)
        {
            this._repositoryWrapper.StationRepositoy.Save(obj);
        }

        public void Update(StationDto obj)
        {
            this._repositoryWrapper.StationRepositoy.UpdateStation(obj);
        }
    }
}
