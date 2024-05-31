using System;
using Rest_NetApi.DBObjects.DBObjects;
using Rest_NetApi.Domain.Entities;
using Rest_NetApi.Domain.Interface.IEntity;

namespace Rest_NetApi.Domain.DTOs
{
	public class UserDto
	{
        public Guid Id { get; set; }

        public string Name { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Profile { get; set; }
        public double credit { get; set; }



        public UserDto()
        {
        }

       
        public UserDto(Guid id, string name, string email, string password, string profile, double credit)
        {
            Id = id;
            Password = password;
            Name = name;
            Profile = profile;
            this.credit = credit;
            Email = email;
        }

        public User ToEntity()
        {
            return new User(this.Id, this.Name, this.Email, this.Password, this.Profile, this.credit);
        }
        public UserDB ToDB()
        {
            return new UserDB(this.Id, this.Name, this.Email, this.Password, this.Profile, this.credit);
        }

    }
}

