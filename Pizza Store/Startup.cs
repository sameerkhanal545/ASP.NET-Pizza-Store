using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Pizza_Store.Startup))]
namespace Pizza_Store
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
