
SELECT TOP 100
    JSON_VALUE(jsonContent, '$.[Index]') AS [Index],
    JSON_VALUE(jsonContent, '$.Date') AS Date,
    CAST(JSON_VALUE(jsonContent, '$.Open') AS FLOAT) AS [Open],
    CAST(JSON_VALUE(jsonContent, '$.High') AS FLOAT) AS [High],
    CAST(JSON_VALUE(jsonContent, '$.Low') AS FLOAT) AS [Low],
    CAST(JSON_VALUE(jsonContent, '$.Close') AS FLOAT) AS [Close],
    CAST(JSON_VALUE(jsonContent, '$."Adj Close"') AS FLOAT) AS AdjClose,
    CAST(JSON_VALUE(jsonContent, '$.Volume') AS FLOAT) AS Volume,
    CAST(JSON_VALUE(jsonContent, '$.CloseUSD') AS FLOAT) AS CloseUSD

FROM
    OPENROWSET(
        BULK 'https://storageacc.dfs.core.windows.net/container/*.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b',
        ROWTERMINATOR = '0x0b'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]
