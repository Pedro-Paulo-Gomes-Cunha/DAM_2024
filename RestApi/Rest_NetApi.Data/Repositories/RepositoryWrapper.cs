using System;
using Rest_NetApi.Domain.Interface.IRepository;

namespace Rest_NetApi.Data.Repositories
{
	public class RepositoryWrapper : IRepositoryWrapper
	{

        IUserRepository _userRepository;
        IStationRepository _stationRepository;
        ISolicitationRepository _solicitationRepository;

        public RepositoryWrapper()
		{
		}

        public IUserRepository UserRepository
        {
            get
            {
                if (_userRepository == null)
                {
                    _userRepository = new UserRepository();
                }
                return _userRepository;
            }
        }


        public IStationRepository StationRepositoy 
        {
            get
            {
                if (_stationRepository == null)
                {
                    _stationRepository = new StationRepository();
                }
                return _stationRepository;
            }
        }

        public ISolicitationRepository SolicitationRepository
        {
            get
            {
                if (_solicitationRepository == null)
                {
                    _solicitationRepository = new SolicitationRepository();
                }
                return _solicitationRepository;
            }
        }

       
    }
}

