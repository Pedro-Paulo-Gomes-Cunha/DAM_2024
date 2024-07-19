using Rest_NetApi.Data.Context;
using Rest_NetApi.DBObjects.DBObjects;
using Rest_NetApi.Domain.DBObjects;
using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Interface.IRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Data.Repositories
{
    public class StationRepository : BaseRepository<StationDB>, IStationRepository
    {
        protected ContextDB Db = new();
        public StationRepository() { }
        public IEnumerable<StationDto> FindAll()
        {
            return GetAll().Select(X=> X.ToDto());
        }

        public StationDto FindById(Guid id)
        {
            var dbObject = GetById(id);

            if (dbObject == null) return null;

            return dbObject.ToDto();
        }

        public IEnumerable<StationDto> FindByStationName(string name)
        {
            var result = Db.Stations.Where(a => a.name.Contains(name)).AsEnumerable();

            if (result == null) return null;

            return result.Select(x=>x.ToDto());
        }

        public void RemoveStation(Guid id)
        {
            var dbObject = GetById(id);

            if (dbObject != null)
                Remove(dbObject);
        }

        public void Save(StationDto obj)
        {
            var dbObject = obj.ToDB();

            dbObject.Id = Guid.NewGuid();

            Add(dbObject);
        }

        public void UpdateStation(StationDto obj)
        {
            var dbObject = obj.ToDB();

            Db.Stations.Update(dbObject);
            Db.SaveChanges();
        }
    }
}
