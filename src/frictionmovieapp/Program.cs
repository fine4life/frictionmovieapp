var builder = WebApplication.CreateBuilder(args);

builder.Services.AddHealthChecks();

var app = builder.Build();

app.MapGet("/", () => Results.Ok(new
{
    application = "frictionmovieapp",
    message = "frictionmovieapp is streaming fine!"
}));

app.MapHealthChecks("/health");

app.Run();

public partial class Program { }
