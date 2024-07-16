using Rest_NetApi.Data.Context;
using Rest_NetApi.DBObjects.DBObjects;
using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Entities;
using Rest_NetApi.Domain.Interface.IRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Data.Repositories
{
    public class UserRepository : BaseRepository<UserDB>, IUserRepository
    {
        protected ContextDB Db = new();
        public IEnumerable<UserDto> FindAll()
        {
            var useres = GetAll();

            return useres.Select(TransformToDto);
        }

        public UserDto FindById(Guid id)
        {
            var dbObject = GetById(id);

            if (dbObject == null) return null;

             return TransformToDto(dbObject);
        }

        public void RemoveUser(Guid id)
        {
            var dbObject = GetById(id);

            if (dbObject != null)
                Remove(dbObject);
        }

        public void Save(UserDto obj)
        {   
            var dbObject = TransformToDBO(obj);

            dbObject.Id = Guid.NewGuid();

            Add(dbObject);
        }

        public void UpdateUser(UserDto obj)
        {
            var dbObject = TransformToDBO(obj);

            Update(dbObject);
        }

        public UserDto UserLogin(string email, string password)
        {
           var  result= Db.Users.FirstOrDefault(a => a.Email.Equals(email) && a.Password.Equals(password));

            if (result == null) return null;

            return TransformToDto(result);
        }

        public UserDto FindByUserName(string name)
        {
            var result = Db.Users.FirstOrDefault(a => a.Name.Equals(name));

            if (result == null) return null;

            return TransformToDto(result);
        }

        private UserDto TransformToDto(UserDB user)
        {
            return new UserDto(user.Id, user.Name, user.Email, user.Password, user.Profile, user.credit);
        }

        private UserDB TransformToDBO(UserDto user)
        {
            return new UserDB(user.Id, user.Name, user.Email, user.Password, user.Profile, user.credit);
        }

        public UserDto FindByEmail(string email)
        {
            var result = Db.Users.FirstOrDefault(a => a.Email.Equals(email));

            if (result == null) return null;

            return TransformToDto(result);
        }
    }
}
