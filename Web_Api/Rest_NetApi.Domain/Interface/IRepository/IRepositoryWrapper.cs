using System;
namespace Rest_NetApi.Domain.Interface.IRepository
{
	public interface IRepositoryWrapper
	{
        IUserRepository UserRepository { get; }
        IStationRepository StationRepositoy { get; }
        ISolicitationRepository SolicitationRepository { get; }
      
    }
}

