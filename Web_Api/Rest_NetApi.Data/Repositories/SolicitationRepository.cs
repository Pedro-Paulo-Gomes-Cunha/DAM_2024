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
    public class SolicitationRepository : BaseRepository<SolicitationDB>, ISolicitationRepository
    {
        public SolicitationRepository() { }
        public IEnumerable<SolicitationDto> FindAll()
        {
            return GetAll().Select(x=>x.ToDto());
        }

        public SolicitationDto FindById(Guid id)
        {
            var dbObject = GetById(id);

            if (dbObject == null) return null;

            return dbObject.ToDto();
        }

        public void RemoveSolicitation(Guid id)
        {
            var dbObject = GetById(id);

            if (dbObject != null)
                Remove(dbObject);
        }

        public void Save(SolicitationDto obj)
        {
            var dbObject = obj.ToDB();

            dbObject.Id = Guid.NewGuid();

            Add(dbObject);
        }

        public void UpdateSolicitation(SolicitationDto obj)
        {
            var dbObject = obj.ToDB();

            Update(dbObject);
        }
    }
}
