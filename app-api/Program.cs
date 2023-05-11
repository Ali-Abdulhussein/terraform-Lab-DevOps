var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => new []{"################## Hello World! #################","################## Hello World! #################"});

app.Run();
