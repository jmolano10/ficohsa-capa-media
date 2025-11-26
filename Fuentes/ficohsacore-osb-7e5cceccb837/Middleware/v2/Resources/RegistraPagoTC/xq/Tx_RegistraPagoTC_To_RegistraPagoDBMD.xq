(:: pragma bea:global-element-parameter parameter="$registraPagoTCRequest1" element="ns2:registraPagoTCRequest" location="../xsd/RegistraPagoTC.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns3:OutputParameters" location="../../../BusinessServices/MasterDataHN/conOrgSequence/xsd/osbConOrgSequence_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters2" element="ns0:OutputParameters" location="../../../../Business_Resources/general/Resources/ObtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../v3/BusinessServices/MasterData/conRegistraPagoTCRG/xsd/conRegistraPagoTCRG_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/registraPagoTCxsd";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conRegistraPagoTCRG";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraPagoTC/xq/Tx_RegistraPagoTC_To_RegistraPagoDBMD/";

declare function xf:Tx_RegistraPagoTC_To_RegistraPagoDBMD($registraPagoTCRequest1 as element(ns2:registraPagoTCRequest),
    $outputParameters1 as element(ns3:OutputParameters),
    $paymentType as xs:string,
    $sourceBank as xs:string,
    $destinationBank as xs:string,
    $merchantDefault as xs:string,
    $merchant as xs:string,
    $channelDefault as xs:string,
    $channel as xs:string,
    $userName as xs:string,
    $authorizationCode as xs:string,
    $outputParameters2 as element(ns0:OutputParameters))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	{ if (data($sourceBank) = 'HN01') 
            then
            	<ns1:Pais>HND</ns1:Pais>
            else 
            	''
            }
            { if (data($sourceBank) = 'GT01') 
            then
            	<ns1:Pais>GTM</ns1:Pais>
            else 
            	''
            }
        	{ if (data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$merchant]/ns0:VALUE!=''))
        	then
        	<ns1:MerchantNumber>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$merchant]/ns0:VALUE) }</ns1:MerchantNumber>
        	else
        	<ns1:MerchantNumber>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$merchantDefault]/ns0:VALUE) }</ns1:MerchantNumber>
        	}
            <ns1:NumTarjeta>{ data($registraPagoTCRequest1/CREDIT_CARD) }</ns1:NumTarjeta>
            <ns1:TipoOperacion>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.BUY']/ns0:VALUE) }</ns1:TipoOperacion>
            { if (data($registraPagoTCRequest1/CURRENCY) = 'HNL') 
            then
            	<ns1:TipoMoneda>1</ns1:TipoMoneda>
            else 
            	<ns1:TipoMoneda>2</ns1:TipoMoneda>
            }            
            <ns1:Organizacion>{ data($outputParameters1/ns3:ORG) }</ns1:Organizacion>
            <ns1:MonedaTransaccion>{ data($registraPagoTCRequest1/CURRENCY) }</ns1:MonedaTransaccion>
            <ns1:TasaCambio>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.RATE']/ns0:VALUE) }</ns1:TasaCambio>
            <ns1:TipoTransaccion>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$paymentType]/ns0:VALUE) }</ns1:TipoTransaccion>
            <ns1:CodigoUsuario>{ $userName }</ns1:CodigoUsuario>
            <ns1:ValorEfectivo>{ data($registraPagoTCRequest1/PAYMENT_AMOUNT) }</ns1:ValorEfectivo>
            <ns1:BancoOrigen>{$sourceBank}</ns1:BancoOrigen>
            <ns1:BancoDestino>{$destinationBank}</ns1:BancoDestino>
            <ns1:DescripcionTXN>{ data($registraPagoTCRequest1/DESCRIPTION) }</ns1:DescripcionTXN>
            {
            if (fn:data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$channel]/ns0:VALUE)!='')
            then
            <ns1:Canal>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$channel]/ns0:VALUE) }</ns1:Canal>
            else
            <ns1:Canal>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$channelDefault]/ns0:VALUE) }</ns1:Canal>   
            }
            <ns1:NoAutorizacion>{$authorizationCode}</ns1:NoAutorizacion>
            <ns1:Aplicado>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.APPLIED']/ns0:VALUE) }</ns1:Aplicado>
            <ns1:AplicarEnLinea>{ data($outputParameters2/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.APPLIED.ONLINE']/ns0:VALUE) }</ns1:AplicarEnLinea>
            <ns1:CodigoError>0</ns1:CodigoError>
            <ns1:MensajeError>temp</ns1:MensajeError>
        </ns1:InputParameters>
};

declare variable $registraPagoTCRequest1 as element(ns2:registraPagoTCRequest) external;
declare variable $outputParameters1 as element(ns3:OutputParameters) external;
declare variable $paymentType as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $merchantDefault as xs:string external;
declare variable $merchant as xs:string external;
declare variable $channelDefault as xs:string external;
declare variable $channel as xs:string external;
declare variable $userName as xs:string external;
declare variable $authorizationCode as xs:string external;
declare variable $outputParameters2 as element(ns0:OutputParameters) external;

xf:Tx_RegistraPagoTC_To_RegistraPagoDBMD($registraPagoTCRequest1,
    $outputParameters1,
    $paymentType,
    $sourceBank,
    $destinationBank,
    $merchantDefault,
    $merchant,
    $channelDefault,
    $channel,
    $userName,
    $authorizationCode,
    $outputParameters2)