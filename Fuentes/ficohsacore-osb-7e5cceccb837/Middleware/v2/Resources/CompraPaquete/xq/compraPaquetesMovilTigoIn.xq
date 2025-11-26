(:: pragma bea:global-element-parameter parameter="$compraPaquete" element="ns0:compraPaquete" location="../xsd/compraPaqueteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:paqueteTigoRequest" location="../../../BusinessServices/Tigo/Paquetes/wsdl/paquetesTigo.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/compraPaqueteTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/paquetesTigo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraPaquete/xq/compraPaquetesMovilTigoIn/";

declare function xf:compraPaquetesMovilTigoIn($compraPaquete as element(ns0:compraPaquete), $TYPE as xs:string, 
$EXTNWCODE as xs:string, $MSISDN as xs:string, $EXTCODE as xs:string, $TransactionID as xs:string)
    as element(ns1:paqueteTigoRequest) {
        <ns1:paqueteTigoRequest>
            <COMMAND>
                <TYPE>{ data($TYPE) }</TYPE>
                <DATE>06/03/2017</DATE>
                <EXTNWCODE>{ data($EXTNWCODE) }</EXTNWCODE>
                <MSISDN>{ data($MSISDN) }</MSISDN>
                <PIN/>
                <LOGINID/>
                <PASSWORD/>
                <EXTCODE>{ data($EXTCODE) }</EXTCODE>
                <EXTREFNUM>{ data($TransactionID) }</EXTREFNUM>
                <MSISDN2>{ fn:concat('504',data($compraPaquete/PHONE_NUMBER)) }</MSISDN2>
                <AMOUNT>{ data($compraPaquete/AMOUNT) }</AMOUNT>
                <SELECTOR>{ if (substring-before(data($compraPaquete/PACK_CODE), data(substring-before($compraPaquete/AMOUNT, "."))) = "") then (substring-before(data($compraPaquete/PACK_CODE), data($compraPaquete/AMOUNT)) ) else (substring-before(data($compraPaquete/PACK_CODE), data(substring-before($compraPaquete/AMOUNT, "."))))  }</SELECTOR>
                <LANGUAGE1/>
                <LANGUAGE2/>
            </COMMAND>
        </ns1:paqueteTigoRequest>
};

declare variable $compraPaquete as element(ns0:compraPaquete) external;
declare variable $TYPE as xs:string external;
declare variable $EXTNWCODE as xs:string external;
declare variable $MSISDN as xs:string external;
declare variable $EXTCODE as xs:string external;
declare variable $TransactionID as xs:string external;



xf:compraPaquetesMovilTigoIn($compraPaquete, $TYPE, $EXTNWCODE, $MSISDN, $EXTCODE, $TransactionID)