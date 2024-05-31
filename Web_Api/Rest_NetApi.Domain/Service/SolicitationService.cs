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
    public class SolicitationService : ISolicitationService
    {
        IRepositoryWrapper _repositoryWrapper;
        public SolicitationService(IRepositoryWrapper repositoryWrapper) {
            this._repositoryWrapper = repositoryWrapper;
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<SolicitationDto> FindAll()
        {
            return this._repositoryWrapper.SolicitationRepository.FindAll();
        }

        public SolicitationDto FindById(Guid id)
        {
            return this._repositoryWrapper.SolicitationRepository.FindById(id);
        }

        public void Remove(Guid id)
        {
            this._repositoryWrapper.SolicitationRepository.RemoveSolicitation(id);
        }

        public void Save(SolicitationDto obj)
        {
                this._repositoryWrapper.SolicitationRepository.Save(obj);
        }

        public void Update(SolicitationDto obj)
        {
            this._repositoryWrapper.SolicitationRepository.UpdateSolicitation(obj);
        }
    }
}
