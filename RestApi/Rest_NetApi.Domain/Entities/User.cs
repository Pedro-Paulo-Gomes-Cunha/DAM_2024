using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Interface.IEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rest_NetApi.Domain.Entities
{
    public class User: IUser
    {
        public Guid Id { get; set; }

        public string Name { get; set; }
        public string Email { get; set; }

        public string Password { get; set; }

        public string Profile { get; set; }

        public double credit { get; set; }


        public User()
        {
        }

        public User(IUser user) : this(user.Id, user.Name, user.Email, user.Password, user.Profile, user.credit) { }

        public User(Guid id,  string name, string email, string password, string profile, double credit)
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
