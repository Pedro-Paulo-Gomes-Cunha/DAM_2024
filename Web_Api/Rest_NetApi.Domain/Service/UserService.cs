using System;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Text.RegularExpressions;
using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Entities;
using Rest_NetApi.Domain.Interface.IRepository;
using Rest_NetApi.Domain.Interface.IService;
using Rest_NetApi.Domain.Validation;

namespace Rest_NetApi.Domain.Service
{
	public class UserService : IUserService
	{
        IRepositoryWrapper _repositoryWrapper;
		public UserService(IRepositoryWrapper repositoryWrapper)
		{
            this._repositoryWrapper = repositoryWrapper;
		}

        public void Save(UserDto obj)
        {
            var userEntiy = obj.ToEntity();
            if (EmailValidation.IsValid(userEntiy.Email) == false)
            {
                throw new Exception("Campo Email é obrigatório, retifique o email");
            }
            if (string.IsNullOrWhiteSpace(userEntiy.Name))
            {
                throw new Exception("Campo Nome é obrigatório!");
            }
            if (string.IsNullOrWhiteSpace(userEntiy.Name) || string.IsNullOrWhiteSpace(userEntiy.Password))
            {
                throw new Exception("Campo Senha é Obrigatório!");
            }

           /* if (_repositoryWrapper.UserRepository.FindByUserName(userEntiy.Name) != null)
            {
                throw new Exception("Já existe um usuário com este nome!");
            }*/

            if (_repositoryWrapper.UserRepository.FindByEmail(userEntiy.Email) != null)
            {
                throw new Exception("Já existe um usuário com este email!");
            }

            _repositoryWrapper.UserRepository.Save(userEntiy.ToDto());
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<UserDto> FindAll()
        {
            return _repositoryWrapper.UserRepository.FindAll();
        }

        public UserDto FindById(Guid id)
        {
            return _repositoryWrapper.UserRepository.FindById(id);
        }

        public void Remove(Guid id)
        {
            throw new NotImplementedException();
        }

        public void Update(UserDto obj)
        {
            var userEntiy = obj.ToEntity();

            if (EmailValidation.IsValid(userEntiy.Email) == false)
            {
                throw new Exception("Campo Email é obrigatório, retifique o email");
            }

            if (string.IsNullOrWhiteSpace(userEntiy.Name))
            {
                throw new Exception("Campo Nome é obrigatório");
            }
            if (string.IsNullOrWhiteSpace(userEntiy.Name) || string.IsNullOrWhiteSpace(userEntiy.Password))
            {
                throw new Exception("Campo Senha é Obrigatório");
            }
            var response = _repositoryWrapper.UserRepository.FindByEmail(userEntiy.Email);
            if (response != null && response.Id!= userEntiy.Id)
            {
                throw new Exception("Já existe um usuário com este email!");
            }
            _repositoryWrapper.UserRepository.UpdateUser(obj);
        }

        public UserDto UserLogin(string email, string password)
        {
            return _repositoryWrapper.UserRepository.UserLogin(email, password);
        }

        public void UpdateCredit(Guid id, double credit)
        {
          var userdto=  this.FindById(id);
            
            if (userdto != null)
            {
                userdto.credit = credit;
                this.Update(userdto);
            }
        }
    }
}

