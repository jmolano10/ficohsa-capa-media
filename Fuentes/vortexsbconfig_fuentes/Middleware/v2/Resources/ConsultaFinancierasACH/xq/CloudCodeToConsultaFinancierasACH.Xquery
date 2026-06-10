<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
(:: import schema at "../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../../BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes.xsd" ::)

declare variable $response as element() (:: schema-element(ns1:entesBancosResponse) ::) external;

declare function local:func($response as element() (:: schema-element(ns1:entesBancosResponse) ::)) as element() (:: schema-element(ns2:consultaFinancierasACHResponse) ::) {
    <ns2:consultaFinancierasACHResponse>
        <ns2:consultaFinancierasACHResponseType>
        {
	  for $consultaFinancierasACHResponseRecordType in $response/ns1:datos/ns1:entes
	  return
            <ns2:consultaFinancierasACHResponseRecordType>
                <DESTINATION_CODE>{fn:data($consultaFinancierasACHResponseRecordType/ns1:codigo)}</DESTINATION_CODE>
                <DESTINATION_NAME>{fn:data($consultaFinancierasACHResponseRecordType/ns1:descripcion)}</DESTINATION_NAME>
            </ns2:consultaFinancierasACHResponseRecordType>
	}
        </ns2:consultaFinancierasACHResponseType>
    </ns2:consultaFinancierasACHResponse>
};

local:func($response)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd">
            <con:schema ref="Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>