using Microsoft.EntityFrameworkCore;
using Rest_NetApi.Data.Context;
using Rest_NetApi.Domain.Interface.IRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Data.Repositories
{
    public class BaseRepository<TEntity> :IDisposable, IRepositoryBase<TEntity> where TEntity : class
    {
        protected ContextDB Db = new();

        public void Add(TEntity obj)
        {
            Db.Set<TEntity>().Add(obj);

            Db.SaveChanges();
        }

        public TEntity GetById(Guid id)
        {
            return Db.Set<TEntity>().Find(id);
        }

        public IEnumerable<TEntity> GetAll()
        {
            return Db.Set<TEntity>().ToList();
        }

        public void Update(TEntity obj)
        {
            Db.Entry(obj).State = EntityState.Modified;

            Db.SaveChanges();
        }

        public void Remove(TEntity obj)
        {
            Db.Set<TEntity>().Remove(obj);

            Db.SaveChanges();
        }

        public void Dispose()
        {

        }
    }
}
