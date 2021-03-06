Select [ProductId], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags],
JSON_VALUE(Data, '$.MadeIn') as MadeIn
from Product
Where JSON_VALUE(Data, '$.Type')  = 'part'


Select JSON_VALUE(Data, '$.Type') as Type, Color,
AVG(cast(JSON_VALUE(Data, '$.ManufacturingCost') as float)) as Cost
from Product
group by JSON_VALUE(Data, '$.Type'), Color
having JSON_VALUE(Data, '$.Type') is not Null
order by JSON_VALUE(Data, '$.Type')

declare @product nvarchar(max) =
N'{"Name": "BB Ball Bearing", "Color":"Magenta", "Size":"62","Price":28.9900, "Quantity":80}'

Select * 
from OPENJSON(@product)
  WITH (Name nvarchar(50), Color nvarchar(15), Size nvarchar(5), Price money, Quantity int)
 GO

Select Name, color, size, price, quantity, JSON_QUERY(Data) as Data, JSON_QUERY(Tags) as Tags from product
for json path 