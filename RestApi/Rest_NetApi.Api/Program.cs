
using Autofac.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Options;
using Rest_NetApi.Api;
using Rest_NetApi.Data.Repositories;
using Rest_NetApi.Domain.Interface.IRepository;
using Rest_NetApi.Domain.Interface.IService;
using Rest_NetApi.Domain.Service;
using Rest_NetApi.IOC;
using System.Reflection;


public class Program
{
    public static void Main(string[] args)
    {
        CreateHostBuilder(args).Build().Run();
    }

    public static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .UseServiceProviderFactory(new AutofacServiceProviderFactory())
            .ConfigureWebHostDefaults(webBuilder =>
            {
                webBuilder.UseStartup<Startup>();
            });
}


