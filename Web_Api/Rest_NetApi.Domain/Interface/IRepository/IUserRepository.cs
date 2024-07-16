using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Domain.Interface.IRepository
{
    public interface IUserRepository 
    {
        IEnumerable<UserDto> FindAll();
        void Save(UserDto obj);
        UserDto FindById(Guid id);
        void UpdateUser(UserDto obj);
        void RemoveUser(Guid id);
        UserDto UserLogin(string email, string password);

        UserDto FindByUserName(string name);
        UserDto FindByEmail(string email);

    }
}
