using Rest_NetApi.Domain.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Domain.Interface.IService
{
    public interface ISolicitationService:IServiceBase<SolicitationDto>
    {
        SolicitationDto FindLastSolicitationByUserId(Guid id);
        IEnumerable<SolicitationDto> FindByUserId(Guid id);
    }
}
