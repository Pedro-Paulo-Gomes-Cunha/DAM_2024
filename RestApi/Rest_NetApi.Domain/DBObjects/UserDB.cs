using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Entities;
using Rest_NetApi.Domain.Interface.IEntity;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Rest_NetApi.DBObjects.DBObjects
{
	public class UserDB
	{
        public Guid Id { get; set; }

        public string Name { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Profile { get; set; }
        public double credit { get; set; }

        public UserDB()
        {
        }

        public UserDB(IUser user) : this(user.Id, user.Name, user.Email, user.Password, user.Profile, user.credit) { }

        public UserDB(Guid id, string name,string email, string password, string profile, double credit)
        {
            Id = id;
            Password = password;
            Name = name;
            Profile = profile;
            this.credit = credit;
            Email = email;
        }

        public UserDto ToDto()
        {
            return new UserDto(this.Id, this.Name, this.Email, this.Password, this.Profile, this.credit);
        }
    }
}