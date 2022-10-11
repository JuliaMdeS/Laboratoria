-- Preparando a tabela
-- Criando a coluna nova de satisfaction_value
CREATE OR REPLACE TABLE `airlinepassengersatisfaction.airline_dataset.passenger-survey` AS
SELECT 
  *, 
  CASE
    WHEN satisfaction = "satisfied" THEN 1
    ELSE 0
  END AS satisfaction_value
  FROM  `airlinepassengersatisfaction.airline_dataset.passenger-survey`;


-- Criando uma coluna que é a soma das notas do passageiro

CREATE OR REPLACE TABLE `airlinepassengersatisfaction.airline_dataset.passenger-survey` AS
SELECT *,
Inflight_wifi_service + Departure_Arrival_time_convenient +	Ease_of_Online_booking + Gate_location +Food_and_drink + Online_boarding + Seat_comfort	+ Inflight_entertainment	+ 
On_board_service	+
Leg_room_service	+
Baggage_handling	+
Checkin_service	+
Inflight_service	+
Cleanliness AS soma_das_notas
FROM  `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- Criando a coluna de segmentação de nota
CREATE OR REPLACE TABLE `airlinepassengersatisfaction.airline_dataset.passenger-survey` AS
SELECT *,
CASE
  WHEN soma_das_notas = 0 THEN 'nao preencheu'
  WHEN soma_das_notas BETWEEN 1 AND 15 THEN 'muito ruim'
  WHEN soma_das_notas BETWEEN 16 AND 30 THEN 'poderia ser melhor'
  WHEN soma_das_notas BETWEEN 31 AND 45 THEN 'nao sei opinar'
  WHEN soma_das_notas BETWEEN 45 AND 60 THEN 'recomendo'
  ELSE 'fantastico'
END AS classificacao_nota
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- Criar tabela com uma segmentacao de atraso
CREATE OR REPLACE TABLE `airlinepassengersatisfaction.airline_dataset.passenger-survey` AS
SELECT *,
CASE 
  WHEN Arrival_Delay_in_Minutes = 0 then 'sem atraso na chegada'
  WHEN Arrival_Delay_in_Minutes BETWEEN 1 AND 30 then '30 minutos de atraso na chegada'
  WHEN Arrival_Delay_in_Minutes BETWEEN 31 AND 60 then '30 a 1 hora de atraso na chegada'
  WHEN Arrival_Delay_in_Minutes BETWEEN 61 AND 120 then '1 a 2 horas de atraso na chegada'
  WHEN Arrival_Delay_in_Minutes BETWEEN 121 AND 240 then '2 a 4 horas de atraso na chegada'
  WHEN Arrival_Delay_in_Minutes BETWEEN 241 AND 480 then '4 a 8 horas de atraso na chegada'
  ELSE 'mais que 8 horas de atraso na chegada'
END AS segmentacao_atraso_chegada
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- Criar uma tabela com segmentacao de flight_duration
CREATE OR REPLACE TABLE `airlinepassengersatisfaction.airline_dataset.passenger-survey` AS
SELECT *,
CASE 
  WHEN Departure_Delay_in_Minutes = 0 then 'sem atraso na partida'
  WHEN Departure_Delay_in_Minutes BETWEEN 1 AND 30 then '30 minutos de atraso na partida'
  WHEN Departure_Delay_in_Minutes BETWEEN 31 AND 60 then '30 a 1 hora de atraso na partida'
  WHEN Departure_Delay_in_Minutes BETWEEN 61 AND 120 then '1 a 2 horas de atraso na partida'
  WHEN Departure_Delay_in_Minutes BETWEEN 121 AND 240 then '2 a 4 horas de atraso na partida'
  WHEN Departure_Delay_in_Minutes BETWEEN 241 AND 480 then '4 a 8 horas de atraso na partida'
  ELSE 'mais que 8 horas de atraso na partida'
END AS segmentacao_atraso_partida
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- Criar uma tabela com segmentacao de idade
CREATE OR REPLACE TABLE `airlinepassengersatisfaction.airline_dataset.passenger-survey` AS
SELECT *,
CASE 
  WHEN Age BETWEEN 1 AND 16 then '1 a 16 anos de idade'
  WHEN Age BETWEEN 17 AND 30 then '17 a 30 anos de idade'
  WHEN Age BETWEEN 31 AND 60 then '31 a 60 anos de idade'
  ELSE 'mais de 60 anos de idade'
END AS segmentacao_idade
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- Criar uma tabela com segmentacao de flight distance

CREATE OR REPLACE TABLE `airlinepassengersatisfaction.airline_dataset.passenger-survey` AS
SELECT *,
CASE 
  WHEN Flight_Distance BETWEEN 1 AND 250 then '1 a 250 km'
  WHEN Flight_Distance BETWEEN 251 AND 750 then '251 a 750 km'
  WHEN Flight_Distance BETWEEN  751 AND 1500 then '751 a 1500 km'
  WHEN Flight_Distance BETWEEN  1501 AND 3000 then '1501 a 3000 km'
  ELSE 'mais que 3000 km'
END AS segmentacao_distancia_do_voo
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- ANALISES

-- Total de passageiros na base -- CARD
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.total_passageiros` AS 
SELECT COUNT(*) as total_passageiros
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- Menor, Maior, Media de idade de passageiros na base -- CARD
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.max_min_avg_idade` AS 
SELECT MIN(Age) as minimo_idade, MAX(Age) AS max_idade, AVG(Age) as media_idade
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- Menor, Maior, Media de flight distance -- CARD
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.max_min_avg_distance` AS 
SELECT MIN(Flight_Distance) min_distance,MAX(Flight_Distance) max_distance, AVG(Flight_Distance) as media_Flight_Distance
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- Menor, Maior, Media de departure delay -- CARD
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.max_min_avg_departure_delay` AS 
SELECT MIN(Departure_Delay_in_Minutes) min_departure_delay,MAX(Departure_Delay_in_Minutes) max_departure_delay, AVG(Departure_Delay_in_Minutes) as media_Departure_Delay_in_Minutes
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- Menor, Maior, Media de idade de passageiros na base -- CARD
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.max_min_avg_arrival_delay` AS 
SELECT MIN(Arrival_Delay_in_Minutes) min_arrival_delay ,MAX(Arrival_Delay_in_Minutes) max_arrival_delay, AVG(Arrival_Delay_in_Minutes) as media_arrival_delay
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- Distribuição de genero
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.distribuicao_genero` AS 
SELECT Gender, COUNT(*) as total_passageiros
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`
GROUP BY 1;

-- Media de distancia da viagem
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.media_distancia_voo` AS 
SELECT AVG(Flight_Distance) as media_flight_distance
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- total de passageiros e media dos serviços por classificacao da nota do passageiro 
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.total_de_passageiros_e_media_por_classificacao_nota` AS 
SELECT
AVG(Inflight_wifi_service) AS media_Inflight_wifi_service,AVG(Departure_Arrival_time_convenient) media_Departure_Arrival_time_convenient,AVG(Ease_of_Online_booking) media_Ease_of_Online_booking,AVG(Gate_location) media_Gate_location,AVG(Food_and_drink) media_Food_and_drink,AVG(Online_boarding) media_Online_boarding,AVG(Seat_comfort) media_Seat_comfort,AVG(Inflight_entertainment) media_Inflight_entertainment,AVG(On_board_service) media_On_board_service,AVG(Leg_room_service) media_Leg_room_service,AVG(Baggage_handling) media_Baggage_handling,AVG(Checkin_service) media_Checkin_service,AVG(Inflight_service) media_Inflight_service,AVG(Cleanliness) media_Cleanliness,
COUNT(*) as total_passageiros, classificacao_nota
  FROM  `airlinepassengersatisfaction.airline_dataset.passenger-survey`
  WHERE Inflight_wifi_service > 0 AND Departure_Arrival_time_convenient > 0 AND Ease_of_Online_booking > 0 AND Gate_location > 0 AND Food_and_drink > 0 AND Online_boarding > 0 AND Seat_comfort > 0 AND Inflight_entertainment > 0 AND On_board_service > 0 AND Leg_room_service > 0 AND Baggage_handling > 0 AND Checkin_service > 0 AND Inflight_service > 0
  GROUP BY classificacao_nota;

-- Total de passageiros por classes de voo, tipo de viagem, customer type
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.total_passageiros_por_types` AS 
SELECT Customer_Type, Type_of_Travel, Class, COUNT(*) as total_passageiros
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;

-- total de passageiros por Classificacao de nota por Types
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.total_passageiros_por_classificacao_nota_e_types` AS 
SELECT  Type_of_Travel, Class, Customer_Type, classificacao_nota, COUNT(*) as total_passageiros
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`
GROUP BY 1,2,3,4
ORDER BY 1,2,3,4;

-- taxa de satisfacao base -- CARD
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.taxa_satisfacao_base` AS 
SELECT AVG(satisfaction_value) as taxa_satisfacao
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`;

-- Taxa de satisfacao por segmentacao de nota
-- Com essa query vimos que exitem 2 passageiros que deram notas ruins de satisfação mas estão classificados como 'satisfied'
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.total_passageiros_e_taxa_de_satisfacao_por_nota` AS 
SELECT COUNT(*) AS total_passageiros, AVG(satisfaction_value) as taxa_satisfacao, classificacao_nota
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`
GROUP BY classificacao_nota;

-- Taxa de satisfacao por distancia do voo
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.taxa_satisfacao_por_segmentacao_distancia_voo` AS 
SELECT  segmentacao_distancia_do_voo, AVG(satisfaction_value) as taxa_satisfacao, COUNT(*) as total_passageiros
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`
GROUP BY 1;

-- Taxa de satisfacao por idade
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.taxa_satisfacao_por_segmentacao_idade` AS 
SELECT  segmentacao_idade, AVG(satisfaction_value) as taxa_satisfacao, COUNT(*) as total_passageiros
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`
GROUP BY 1;

-- Taxa de satisfação por classe
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.taxa_satisfacao_por_Class` AS 
SELECT  Class, AVG(satisfaction_value) as taxa_satisfacao, COUNT(*) as total_passageiros
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`
GROUP BY 1;


-- Taxa de satisfação por Customer_Type
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.taxa_satisfacao_por_Customer_Type` AS 
SELECT  Customer_Type, AVG(satisfaction_value) as taxa_satisfacao, COUNT(*) as total_passageiros
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`
GROUP BY 1;


-- Taxa de satisfação por Type_of_Travel
CREATE TABLE `airlinepassengersatisfaction.airline_dataset.taxa_satisfacao_por_Type_of_Travel` AS 
SELECT  Type_of_Travel, AVG(satisfaction_value) as taxa_satisfacao, COUNT(*) as total_passageiros
FROM `airlinepassengersatisfaction.airline_dataset.passenger-survey`
GROUP BY 1;

