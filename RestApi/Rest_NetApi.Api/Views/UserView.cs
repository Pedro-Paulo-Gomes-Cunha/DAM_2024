using System;
using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Entities;

namespace Rest_NetApi.Api.Views
{
	public class UserView
	{
        public Guid Id { get; set; }

        public string Name { get; set; }
        public string Email { get; set; }

        public string Password { get; set; }
        public string Profile { get; set; }

        public double credit { get; set; }

        public UserView()
        {
        }

        public UserView(Guid id, string name, string email, string password, string profile, double credit_)
        {
            Id = id; 
            Password = password;
            Name = name;
            Profile = profile;
            credit = credit_;
            Email = email;
        }

        public UserDto ToDto()
        {
            return new UserDto(this.Id, this.Name, this.Email, this.Password, this.Profile, this.credit);
        }

    }
}

