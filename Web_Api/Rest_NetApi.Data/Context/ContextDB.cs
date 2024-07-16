using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Primitives;
using Rest_NetApi.DBObjects.DBObjects;
using Rest_NetApi.Domain.DBObjects;
using Rest_NetApi.Domain.Entities;
using Rest_NetApi.Domain.Interface.IEntity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Reflection.Emit;
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Rest_NetApi.Data.Context
{
    public class ContextDB : DbContext
    {

        public ContextDB() : base()
        {

        }

        public ContextDB(DbContextOptions<DbContext> options):base(options)
        {
            
        }
        protected override void OnConfiguring(DbContextOptionsBuilder options)
         {
            ////"User=.;Password=SurielSuriel;Database=project;Server=SQLEXPRESS;
           // var stringConexao = "Data Source=DESKTOP-G4UNLMH\\SQLEXPRESS;Database=TesteDB1;Integrated Security=True;TrustServerCertificate=true;MultipleActiveResultSets=true";
           var stringConexao = "Server=USER\\SQLEXPRESS;Database=dam_2024;User=.;Password=123456789;Integrated Security=True;TrustServerCertificate=true";
            options.UseSqlServer(stringConexao);
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

           modelBuilder.Entity<UserDB>().Property(e => e.Profile).HasDefaultValueSql("user");

            base.OnModelCreating(modelBuilder);
  
        }


        public DbSet<UserDB> Users { get; set; }
        public DbSet<StationDB> Stations{ get; set; }
        public DbSet<SolicitationDB> Solicitations { get; set; }





    }
}
