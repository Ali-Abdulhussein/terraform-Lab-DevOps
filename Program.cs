var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => new []{"################## Hello World! ######## 01 #########","################## Hello World! ######## 02 #########","################## Hello World! ######## 03 #########"});

app.Run();
