using Rest_NetApi.Domain.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Domain.Interface.IRepository
{
    public interface ISolicitationRepository
    {
        IEnumerable<SolicitationDto> FindAll();
        void Save(SolicitationDto obj);
        SolicitationDto FindById(Guid id);
        void UpdateSolicitation(SolicitationDto obj);
        void RemoveSolicitation(Guid id);
        SolicitationDto FindLastSolicitationByUserId(Guid id);
    }
}
