xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/iNSTransaccionRedencion/xsd/INSTransaccionRedencion_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/INSTransaccionRedencion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RedencionPuntosLealtad/xq/insTransaccionRedencionIn/";

declare function xf:insTransaccionRedencionIn($cardNumber as xs:string,
    $amount as xs:string,
    $merchant as xs:string,
    $description as xs:string,
    $serviceId as xs:string,
    $channelId as xs:string,
    $countryCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:NumeroTarjeta>{ $cardNumber }</ns0:NumeroTarjeta>
            <ns0:Monto>{ data($amount) }</ns0:Monto>
            <ns0:Comercio>{ $merchant }</ns0:Comercio>
            {
            	if($description != "") then (
            		<ns0:Descripcion>{ $description }</ns0:Descripcion>
            	) else ()
            }
            {
            	if($serviceId != "") then (
            		<ns0:IDServicio>{ data($serviceId) }</ns0:IDServicio>
            	) else ()
            }
            {
            	if($channelId != "") then (
            		<ns0:IDCanal>{ data($channelId) }</ns0:IDCanal>
            	) else ()
            }
            <ns0:Pais>{ $countryCode }</ns0:Pais>
        </ns0:InputParameters>
};

declare variable $cardNumber as xs:string external;
declare variable $amount as xs:string external;
declare variable $merchant as xs:string external;
declare variable $description as xs:string external;
declare variable $serviceId as xs:string external;
declare variable $channelId as xs:string external;
declare variable $countryCode as xs:string external;

xf:insTransaccionRedencionIn($cardNumber,
    $amount,
    $merchant,
    $description,
    $serviceId,
    $channelId,
    $countryCode)