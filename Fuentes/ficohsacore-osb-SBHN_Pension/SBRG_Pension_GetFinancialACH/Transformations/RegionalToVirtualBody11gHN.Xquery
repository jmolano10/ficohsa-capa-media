<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
(:: import schema at "../Schemas/ConsultaFinancierasACHTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFinancialACHTypes.xsd" ::)

declare variable $responseRegional as element() (:: schema-element(ns1:getFinancialACHResponse) ::) external;

declare function local:funcRegionalToVirtualBody11gHN($responseRegional as element() (:: schema-element(ns1:getFinancialACHResponse) ::)) as element() (:: schema-element(ns2:consultaFinancierasACHResponse) ::) {
    <ns2:consultaFinancierasACHResponse>
        <ns2:consultaFinancierasACHResponseType>
        {
          for $entity in $responseRegional/Data/Entities
          return 
           <ns2:consultaFinancierasACHResponseRecordType>
                <DESTINATION_CODE>{fn:data($entity/Code)}</DESTINATION_CODE>
                <DESTINATION_NAME>{fn:data($entity/Description)}</DESTINATION_NAME>
                <ns2:consultaFinancierasACHDetailResponseType>
                    <ns2:consultaFinancierasACHDetailResponseRecordType>
                        <TYPE_OF_PRODUCT></TYPE_OF_PRODUCT>
                        <MIN_PRODUCT_ID_LENGTH></MIN_PRODUCT_ID_LENGTH>
                        <MAX_PRODUCT_ID_LENGTH></MAX_PRODUCT_ID_LENGTH>
                        <LEADING_ZEROS_YES_NO></LEADING_ZEROS_YES_NO>
                        <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                        <TRANSFER_TYPE></TRANSFER_TYPE>
                    </ns2:consultaFinancierasACHDetailResponseRecordType>
                </ns2:consultaFinancierasACHDetailResponseType>
            </ns2:consultaFinancierasACHResponseRecordType>
        }
        </ns2:consultaFinancierasACHResponseType>
    </ns2:consultaFinancierasACHResponse>
};

local:funcRegionalToVirtualBody11gHN($responseRegional)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaFinancierasACHTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFinancialACH/Schemas/ConsultaFinancierasACHTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetFinancialACHTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFinancialACH/Schemas/GetFinancialACHTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>