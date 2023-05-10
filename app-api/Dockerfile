FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

ENV ASPNETCORE_URLS=http://+:80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["app-api.csproj", "./"]
RUN dotnet restore "app-api.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "app-api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "app-api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "app-api.dll"]
