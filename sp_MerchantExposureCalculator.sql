USE [Shelby]
GO
/****** Object:  StoredProcedure [dbo].[sp_MerchantExposureCalculator]    Script Date: 1/2/2020 11:33:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************/
--- Exposure Calculations Stored Procedure
--- MCC experience output calculations 
--- Table Database 
--- 
/**************/
---			Exec sp_MerchantExposureCalculator @mcc = 1111, @newVol = 0, @current = 25000000;

ALTER PROCEDURE [dbo].[sp_MerchantExposureCalculator]
@mcc varchar(10),
@newVol int NULL,
@current int NULL,
@monthly int = 12,
@yearly int = 365,
@60DayEstReturn int = 60,
@120DayEstChargeback int = 120



AS
Begin

Declare @MechantExposure Table
(
 Bookstores varchar(255),
 MCC varchar(10) NULL,
 RiskLevel varchar(255)  NULL,
 MonthlyNewVolume varchar(255) NULL,
 MonthlyCurrent varchar(255) NULL,
 MonthlyTotal varchar(255) NULL,
 AnnualTotal varchar(255) NULL,
 CardNotPresent varchar(255) NULL,
 CardNotPresentTxn varchar(255) NULL,
 CardNotPresentTotal int NULL,
 DayPercentage60 varchar(255) NULL,
 DayEstimatedTotal60 int NULL,
 DayPercentage120 decimal(7,4) NULL,
 DayEstimated120 varchar(255) NULL,
 DayEstimatedTotal int NULL,
 FutureDeliveryTotal int NULL
)

Declare @annual AS int
Declare @newVolume AS int
Declare @currentVol AS int
Declare @estDaysFuture AS float
Declare @contigentExpGross As Numeric
Set @newVolume = @newVol / @monthly
Set @currentVol = @current / @monthly
Set @annual = @newVol + @current

Set @estDaysFuture = (select EstFutureDelivery.FutureDelivery from DataBaseTemp
                      join EstFutureDelivery on DataBaseTemp.RiskLevel = EstFutureDelivery.RiskLevel 
					  where mcc = @mcc)


insert into @MechantExposure(
 Bookstores,
 MCC,
 RiskLevel,
 MonthlyNewVolume,
 MonthlyCurrent,
 MonthlyTotal,
 AnnualTotal,
 CardNotPresent,
 CardNotPresentTxn,
 CardNotPresentTotal,
 DayPercentage60,
 DayEstimatedTotal60,
 DayPercentage120,
 DayEstimated120,
 DayEstimatedTotal,
 FutureDeliveryTotal
 )

 select Bookstores, 
       MCC,
	   RiskLevel,
	   @newVolume, 	   
	   @currentVol,
	   @newVol + @current / @monthly,
	   @annual,	   	 
	   CNPFactor,
	   Cast(Cast((CNPTxn)*100 as decimal(7,4)) as varchar(100)), 
	   ROUND((((@newVol + @current)* CNPTxn)/@yearly * CNPFactor), 0),
       Cast(Cast(([120dayestreturn])*100 as decimal(7,4)) as varchar(100)),
	   Case when @60DayEstReturn < @estDaysFuture Then 0 Else Round((@annual * [120dayestreturn])/@yearly * (@60DayEstReturn - @estDaysFuture), 0) end,  
	   Cast(Cast(([60dayCB])*100 as decimal(7,4)) as varchar(100)),
	   Case when @60DayEstReturn < @estDaysFuture Then 0 Else ROUND(((@annual * [60dayCB]) / @yearly * (@120DayEstChargeback - @estDaysFuture)), 0) end,
	   Case when @60DayEstReturn < @estDaysFuture Then 0 Else @estDaysFuture end,	   
	   Round((@annual * @estDaysFuture) / @yearly, 0)
From DatabaseTemp
where mcc = @mcc

set @contigentExpGross = (SELECT sum(Cast(CardNotPresentTotal+DayEstimatedTotal60 + DayEstimated120 + FutureDeliveryTotal as int)) from @MechantExposure)

Select
 MCC = (SELECT mcc = CASE WHEN LEN(mcc) = 3  THEN '0' + mcc ELSE mcc END
         From @MechantExposure where mcc = mcc),
 Bookstores as 'DescriptiveCategory',
 RiskLevel as'ExposureCode',
 MonthlyNewVolume as 'NewVolume',
 MonthlyCurrent,
 MonthlyTotal,
 AnnualTotal,
 CardNotPresent as 'CardNotPresent',
 CardNotPresentTxn as 'CardNotPresentPercentage',
 CardNotPresentTotal,
 DayPercentage60 As '60DayEstimatedReturn',
 DayEstimatedTotal60,
 DayEstimated120,
 DayPercentage120 As '120DayEstimatedChargeback',
 DayEstimatedTotal,
 FutureDeliveryTotal,
 @contigentExpGross As 'ContigentExposure'
 from @MechantExposure
END

