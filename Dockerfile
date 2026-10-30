# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["SmartShop.APISShop.API.csproj", "SmartShop.API/"]
RUN dotnet restore "SmartShop.API/SShop.API.csproj"
COPY . .
WORKDIR "/src/SmartShop.API"
RUN dotnet publish "SShop.API.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "SShop.API.dll"]
