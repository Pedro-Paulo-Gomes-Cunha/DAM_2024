using System;
using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Entities;

namespace Rest_NetApi.Domain.Interface.IService
{
	public interface IUserService : IServiceBase<UserDto>
	{
        UserDto UserLogin(string email, string password);
       // UserDto FindByUserName(string name);
       void UpdateCredit(Guid id, double credit);
    }
}

