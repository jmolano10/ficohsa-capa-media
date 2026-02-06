xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registraPagoTCRequest1" element="ns2:registraPagoTCRequest" location="../xsd/RegistraPagoTC.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters2" element="ns0:OutputParameters" location="../../../../Business_Resources/general/Resources/ObtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../v3/BusinessServices/PAGOSWSTC/registraPagoTC/xsd/registraPagoTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/registraPagoTCxsd";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraPagoTC/xq/Tx_RegistraPagoTC_To_RegistraPagoDB/";

declare function xf:Tx_RegistraPagoTC_To_RegistraPagoDB($registraPagoTCRequest1 as element(ns2:registraPagoTCRequest),
    $outputParameters2 as element(ns0:OutputParameters),
    $paymentType as xs:string,
    $ORG as xs:string,
    $sourceBank as xs:string,
    $destinationBank as xs:string,
    $merchantDefault as xs:string,
    $merchant as xs:string,
    $channelDefault as xs:string,
    $channel as xs:string,
    $userName as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	{ if (data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$merchant]/ns0:VALUE!=''))
        	then
        	<ns1:PV_MERCHANTNUMBER>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$merchant]/ns0:VALUE) }</ns1:PV_MERCHANTNUMBER>
        	else
        	<ns1:PV_MERCHANTNUMBER>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$merchantDefault]/ns0:VALUE) }</ns1:PV_MERCHANTNUMBER>
        	}
            <ns1:PV_NUMEROTARJETA>{ data($registraPagoTCRequest1/CREDIT_CARD) }</ns1:PV_NUMEROTARJETA>
            <ns1:PV_TIPOOPERACION>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.REVERSE']/ns0:VALUE) }</ns1:PV_TIPOOPERACION>
            { if (data($registraPagoTCRequest1/CURRENCY) = 'HNL') 
            then
            	<ns1:PN_TIPOMONEDA>1</ns1:PN_TIPOMONEDA>
            else 
            	<ns1:PN_TIPOMONEDA>2</ns1:PN_TIPOMONEDA>
            } 
            <ns1:PN_ORGANIZACION>{ $ORG }</ns1:PN_ORGANIZACION>
            <ns1:PV_MONEDATRANSACCION>{ data($registraPagoTCRequest1/CURRENCY) }</ns1:PV_MONEDATRANSACCION>
            <ns1:PN_TASACAMBIO>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.RATE']/ns0:VALUE) }</ns1:PN_TASACAMBIO>
            <ns1:PN_TIPOTRANSACCION>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$paymentType]/ns0:VALUE) }</ns1:PN_TIPOTRANSACCION>
            <ns1:PV_CODIGOUSUARIO>{$userName}</ns1:PV_CODIGOUSUARIO>
            <ns1:PN_VALOREFECTIVO>{ data($registraPagoTCRequest1/PAYMENT_AMOUNT) }</ns1:PN_VALOREFECTIVO>
            <ns1:PV_BANCOORIGEN>{$sourceBank}</ns1:PV_BANCOORIGEN>
            <ns1:PV_BANCODESTINO>{$destinationBank}</ns1:PV_BANCODESTINO> 
            <ns1:PV_DESCRIPCIONTRANSACCION>{ data($registraPagoTCRequest1/DESCRIPTION) }</ns1:PV_DESCRIPCIONTRANSACCION>
            {
            if (fn:data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$channel]/ns0:VALUE)!='')
            then
            <ns1:PV_CANAL>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$channel]/ns0:VALUE) }</ns1:PV_CANAL>
            else
            <ns1:PV_CANAL>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$channelDefault]/ns0:VALUE) }</ns1:PV_CANAL>  
            }
            <ns1:PV_APLICADO>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.APPLIED']/ns0:VALUE) }</ns1:PV_APLICADO>
            <ns1:PV_APLICARENLINEA>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.APPLIED.ONLINE']/ns0:VALUE) }</ns1:PV_APLICARENLINEA>
        </ns1:InputParameters>
};

declare variable $registraPagoTCRequest1 as element(ns2:registraPagoTCRequest) external;
declare variable $outputParameters2 as element(ns0:OutputParameters) external;
declare variable $ORG as xs:string external;
declare variable $paymentType as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $merchantDefault as xs:string external;
declare variable $merchant as xs:string external;
declare variable $channelDefault as xs:string external;
declare variable $channel as xs:string external;
declare variable $userName as xs:string external;



xf:Tx_RegistraPagoTC_To_RegistraPagoDB($registraPagoTCRequest1,
    $outputParameters2,
    $paymentType,
    $ORG,
    $sourceBank,
    $destinationBank,
    $merchantDefault,
    $merchant,
    $channelDefault,
    $channel,
    $userName
    )