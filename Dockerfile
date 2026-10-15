FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY src/frictionmovieapp/frictionmovieapp.csproj src/frictionmovieapp/
RUN dotnet restore src/frictionmovieapp/frictionmovieapp.csproj

COPY src/frictionmovieapp/ src/frictionmovieapp/
RUN dotnet publish src/frictionmovieapp/frictionmovieapp.csproj \
    --configuration Release \
    --output /app/publish \
    --no-restore \
    /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app

ENV ASPNETCORE_HTTP_PORTS=3030
EXPOSE 3030

COPY --from=build /app/publish .
USER $APP_UID

ENTRYPOINT ["dotnet", "frictionmovieapp.dll"]