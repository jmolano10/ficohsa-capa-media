(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../v2/BusinessServices/MasterData/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjconsultaDatosTarjetaCredito" location="../../../BusinessServices/SJS/consultaDatosTarjetaCredito/xsd/sjconsultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjconsultaDatosTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaDatosTarjetaCredito/xq/sjConsultaDatosTarjetaCreditoNIIn/";

declare function xf:sjConsultaDatosTarjetaCreditoNIIn($outputParameters as element(ns0:OutputParameters),
    $countryCode as xs:string)
    as element(ns1:sjconsultaDatosTarjetaCredito) {
        <ns1:sjconsultaDatosTarjetaCredito>
            <COUNTRY_CODE>{ $countryCode }</COUNTRY_CODE>
            {
                for $rowDatosTarjeta in $outputParameters/ns0:RowSet/ns0:Row
                return
                    <CARD_INFORMATION>
                        <CARD_NUMBER>{ data($rowDatosTarjeta/ns0:Column[@name = 'numtarjeta']/text()) }</CARD_NUMBER>
                        <ORG>{ data($rowDatosTarjeta/ns0:Column[@name = 'org']/text()) }</ORG>
                        <ORG_TYPE>{ data($rowDatosTarjeta/ns0:Column[@name = 'TipoOrg']/text()) }</ORG_TYPE>
                    </CARD_INFORMATION>
            }
        </ns1:sjconsultaDatosTarjetaCredito>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $countryCode as xs:string external;

xf:sjConsultaDatosTarjetaCreditoNIIn($outputParameters,
    $countryCode)