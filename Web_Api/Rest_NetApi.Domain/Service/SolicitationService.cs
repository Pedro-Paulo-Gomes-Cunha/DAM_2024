using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Entities;
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
            var list = this._repositoryWrapper.SolicitationRepository.FindAll().ToList();
            for (int i = 0; i < list.Count; i++)
            {
                var name = this._repositoryWrapper.StationRepositoy.FindById(list[i].stationReturn)?.name;
                list[i].Source = this._repositoryWrapper.StationRepositoy.FindById(list[i].station).name;
                list[i].Destiny =  name == null ? string.Empty:name;
            }
            return list.AsEnumerable();
        }

        public SolicitationDto FindById(Guid id)
        {
            var SolicitationCopy = this._repositoryWrapper.SolicitationRepository.FindById(id);

            var name = this._repositoryWrapper.StationRepositoy.FindById(SolicitationCopy.stationReturn)?.name;
            SolicitationCopy.Source = this._repositoryWrapper.StationRepositoy.FindById(SolicitationCopy.station).name;
            SolicitationCopy.Destiny  = name == null ? string.Empty : name;

            return SolicitationCopy;
        }

        public IEnumerable<SolicitationDto> FindByUserId(Guid id)
        {
            var list = this._repositoryWrapper.SolicitationRepository.FindByUserId(id).ToList();
            for (int i = 0; i < list.Count; i++)
            {
                var name = this._repositoryWrapper.StationRepositoy.FindById(list[i].stationReturn)?.name;
                list[i].Source = this._repositoryWrapper.StationRepositoy.FindById(list[i].station).name;
                list[i].Destiny = name == null ? string.Empty : name;
            }
            return list.AsEnumerable();
        }

        public SolicitationDto FindLastSolicitationByUserId(Guid id)
        {
            var SolicitationCopy = this._repositoryWrapper.SolicitationRepository.FindLastSolicitationByUserId(id);
            var name = this._repositoryWrapper.StationRepositoy.FindById(SolicitationCopy.stationReturn)?.name;
            SolicitationCopy.Source = this._repositoryWrapper.StationRepositoy.FindById(SolicitationCopy.station).name;
            SolicitationCopy.Destiny = name == null ? string.Empty : name;

            return SolicitationCopy;
        }

        public void Remove(Guid id)
        {
            this._repositoryWrapper.SolicitationRepository.RemoveSolicitation(id);
        }

        public void Save(SolicitationDto obj)
        {
            try
            {
                //verificar se o user tem pontos suficientes
                var user = this._repositoryWrapper.UserRepository.FindById(obj.UserId);
                if (user.credit < 1)
                    throw new Exception("Usuário sem créditos suficiente!");
                //verificar se a estação tem docas disponiveis

                var station = this._repositoryWrapper.StationRepositoy.FindById(obj.station);
                if (station.availableBikeShared <= 0)
                    throw new Exception("Estação sem docas disponível");

                //Diminuir os pontos do user
                user.credit = user.credit - 1;
                this._repositoryWrapper.UserRepository.UpdateUser(user);

                //Diminuir o numero de docas disponíveis
                station.freeDocks = station.freeDocks + 1;
                station.availableBikeShared = station.availableBikeShared - 1;
                this._repositoryWrapper.StationRepositoy.UpdateStation(station);

                this._repositoryWrapper.SolicitationRepository.Save(obj);
            }
            catch (Exception ex)
            {

            }
          
        }

        public void Update(SolicitationDto obj)
        {
            try
            {
                var user = this._repositoryWrapper.UserRepository.FindById(obj.UserId);

                //verificar se a estação tem docas free

                var station = this._repositoryWrapper.StationRepositoy.FindById(obj.stationReturn);
                if (station.freeDocks <=0)
                    throw new Exception("Estação sem docas vazias");

                //atribuir bonus de pontos ao user
                user.credit = user.credit + 0.5;
                this._repositoryWrapper.UserRepository.UpdateUser(user);

                //Diminuir o numero de docas disponíveis
                station.freeDocks = station.freeDocks - 1;
                station.availableBikeShared = station.availableBikeShared + 1;
                station.totalReturns= station.totalReturns + 1;
                this._repositoryWrapper.StationRepositoy.UpdateStation(station);

                this._repositoryWrapper.SolicitationRepository.UpdateSolicitation(obj);
            }
            catch (Exception ex)
            {

            }
        }
    }
}
